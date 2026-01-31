//
//  DetailOrderUseCase.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

protocol DetailOrderUseCaseProtocol {
    func saveBucket(_ bucket: BucketModel) async
}

final class DetailOrderUseCase {
    private let repository: BucketRepositoryProtocol
    
    init(repository: BucketRepositoryProtocol) {
        self.repository = repository
    }
}

extension DetailOrderUseCase: DetailOrderUseCaseProtocol {
    func saveBucket(_ bucket: BucketModel) async {
        await repository.saveBucket(bucket)
    }
}
