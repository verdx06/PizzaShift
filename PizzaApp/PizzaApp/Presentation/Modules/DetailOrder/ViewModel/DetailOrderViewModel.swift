//
//  DetailOrderViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

final class DetailOrderViewModel: ObservableObject {
    @Published private(set) var state: State
    @Published private(set) var additionalIngredients: [PizzaIngredient] = []
    @Published var selectedSize: PizzaSize {
        didSet {
            updateTotalSum()
        }
    }
    @Published private var bucket: BucketModel
    @Published private(set) var totalSum: Int = 0
    
    let pizza: PizzaModel
    private let useCase: DetailOrderUseCaseProtocol
    private let router: Router
    
    init(pizza: PizzaModel, useCase: DetailOrderUseCaseProtocol, router: Router) {
        self.pizza = pizza
        self.useCase = useCase
        self.router = router
        let defaultSize = pizza.sizes.first(where: { $0.type == .small }) ?? pizza.sizes.first ?? PizzaSize(type: .small, price: 0)
        self.selectedSize = defaultSize
        self.bucket = .init()
        self.state = .loaded
        self.updateTotalSum()
    }
    
    func tapIngredientAndUpdateSum(topping: PizzaIngredient) {
        if self.additionalIngredients.contains(where: { $0.type == topping.type }) {
            self.additionalIngredients.removeAll(where: { $0.type == topping.type })
        } else {
            self.additionalIngredients.append(topping)
        }
        updateTotalSum()
    }
    
    func tapDesignOrder() {
        let item = BucketItem(
            pizza: pizza,
            topings: additionalIngredients,
            selectedSize: selectedSize
        )
        bucket = BucketModel(buckets: [item])
        Task { @MainActor in
            await useCase.saveBucket(bucket)
            router.showBucketHandler()
        }
    }
}

private extension DetailOrderViewModel {
    
    func updateTotalSum() {
        let sumIngredients = additionalIngredients.reduce(0) { $0 + $1.price }
        totalSum = selectedSize.price + sumIngredients
    }
}
