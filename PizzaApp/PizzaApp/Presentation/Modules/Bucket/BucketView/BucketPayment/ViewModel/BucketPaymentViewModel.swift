//
//  BucketPaymentViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

final class BucketPaymentViewModel: ObservableObject {
    
    private let useCase: BucketUseCaseProtocol
    private let router: Router
    private let checkoutData: CheckoutData
    @Published var cardNumber = ""
    @Published var cardExpiry = ""
    @Published var cardCVV = ""
    
    init(checkoutData: CheckoutData, useCase: BucketUseCaseProtocol, router: Router) {
        self.checkoutData = checkoutData
        self.useCase = useCase
        self.router = router
    }
}

@MainActor
extension BucketPaymentViewModel {
    func tapButton() {
        Task {
            do {
                let bucket = await getBucket()
                let cardData = DebitCard(
                    pan: cardNumber,
                    expireDate: cardExpiry,
                    cvv: cardCVV
                )
                try await self.useCase.createOrder(
                    bucket: bucket,
                    checkoutData: self.checkoutData,
                    cardData: cardData
                )
                await self.useCase.removeItems()
                self.nextHandler()
            } catch {
                #if DEBUG
                print("create Order error: \(error.localizedDescription)")
                #endif
            }
        }
    }
}

private extension BucketPaymentViewModel {
    func nextHandler() {
        self.router.showNextHandler()
    }
    
    func getBucket() async -> BucketModel {
        await self.useCase.loadBucket() ?? BucketModel()
    }
}
