//
//  RepositoryFactory.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

final class RepositoryFactory {
    lazy var networkService: BaseNetworkProtocol = BaseNetwork()
    lazy var authRepository: AuthRepositoryProtocol = AuthRepository(network: self.networkService)
    lazy var homeRepository: HomeRepositoryProtocol = HomeRepository(network: self.networkService)
    lazy var bucketRepository: BucketRepositoryProtocol = BucketRepository(network: self.networkService)
}
