//
//  BucketUseCase.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

protocol BucketUseCaseProtocol {
    func removeItems() async
    func saveBucket(_ bucket: BucketModel) async
    func loadBucket() async -> BucketModel?
    func createOrder(bucket: BucketModel, checkoutData: CheckoutData, cardData: DebitCard) async throws
}

final class BucketUseCase {
    private let repository: BucketRepositoryProtocol
    
    init(repository: BucketRepositoryProtocol) {
        self.repository = repository
    }
}

extension BucketUseCase: BucketUseCaseProtocol {
    func createOrder(bucket: BucketModel, checkoutData: CheckoutData, cardData: DebitCard) async throws {
        try await repository.createOrder(
            bucket: bucket,
            checkoutData: checkoutData,
            cardData: cardData
        )
    }
    
    func removeItems() async {
        await repository.removeItems()
    }
    
    func saveBucket(_ bucket: BucketModel) async {
        await self.repository.saveBucket(bucket)
    }
    
    func loadBucket() async -> BucketModel? {
        await repository.loadBucket()
    }
}
