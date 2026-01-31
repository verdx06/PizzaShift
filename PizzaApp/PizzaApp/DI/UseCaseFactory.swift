//
//  UseCaseFactory.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

final class UseCaseFactory {
    private let repositoryFactory: RepositoryFactory

    init(repositoryFactory: RepositoryFactory) {
        self.repositoryFactory = repositoryFactory
    }
}

extension UseCaseFactory {
    func makeAuthUseCase() -> AuthUseCaseProtocol {
        AuthUseCase(repository: self.repositoryFactory.authRepository)
    }
}

extension UseCaseFactory {
    func makeHomeUseCase() -> HomeUseCaseProtocol {
        HomeUseCase(repository: self.repositoryFactory.homeRepository)
    }
}

extension UseCaseFactory {
    func makeDetailOrderUseCase() -> DetailOrderUseCaseProtocol {
        DetailOrderUseCase(repository: self.repositoryFactory.bucketRepository)
    }
}

extension UseCaseFactory {
    func makeBucketUseCase() -> BucketUseCaseProtocol {
        BucketUseCase(repository: self.repositoryFactory.bucketRepository)
    }
}
