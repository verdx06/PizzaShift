//
//  BucketViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

final class BucketViewModel: ObservableObject {
    @Published private(set) var bucket: BucketModel = .init()
    @Published private(set) var state: State
    private let router: Router
    private let useCase: BucketUseCaseProtocol

    init(router: Router, useCase: BucketUseCaseProtocol) {
        self.state = .loaded
        self.router = router
        self.useCase = useCase
    }

    func loadBucket() {
        Task {
            await MainActor.run {
                self.state = .loading
            }
            if let loaded = await useCase.loadBucket() {
                await MainActor.run {
                    self.bucket = loaded
                    self.state = loaded.buckets.isEmpty ? .empty : .loaded
                }
            } else {
                await MainActor.run {
                    self.bucket = .init()
                    self.state = .empty
                }
            }
        }
    }
    
    var totalPrice: Int {
        bucket.buckets.reduce(0) { total, item in
            let itemPrice = item.selectedSize.price + item.topings.reduce(0) { $0 + $1.price }
            return total + itemPrice
        }
    }
    
    func formatPizzaDescription(item: BucketItem) -> String {
        let sizeText: String
        let diameter: String
        switch item.selectedSize.type {
        case .small:
            sizeText = "Маленькая"
            diameter = "25"
        case .medium:
            sizeText = "Средняя"
            diameter = "30"
        case .large:
            sizeText = "Большая"
            diameter = "35"
        }
        
        let doughText = item.pizza.doughs.first?.type ?? "традиционное тесто"
        
        var description = "\(sizeText) \(diameter) см, \(doughText)"
        
        if !item.topings.isEmpty {
            let toppingsText = item.topings.map { $0.type }.joined(separator: ", ")
            description += " + \(toppingsText)"
        }
        
        return description
    }

    func tapCheckout() {
        router.showCheckoutHandler()
    }

//    func remove(at offsets: IndexSet) {
//        let ids = offsets.compactMap { index in
//            guard bucket.buckets.indices.contains(index) else {
//                return nil
//            }
//            return bucket.buckets[index].id
//        }
//        Task {
//            for id in ids {
//                _ = await useCase.deleteItem(id: id)
//            }
//            if let loaded = await useCase.loadBucket() {
//                await MainActor.run {
//                    self.bucket = loaded
//                }
//            }
//        }
//    }
}
