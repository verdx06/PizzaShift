//
//  HomeRepository.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

protocol HomeRepositoryProtocol {
    func getPizzas() async throws -> PizzaCatalogResponse
}

final class HomeRepository {
    private let network: BaseNetworkProtocol
    
    init(network: BaseNetworkProtocol) {
        self.network = network
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    func getPizzas() async throws -> PizzaCatalogResponse {
        let result: PizzaCatalogResponse = try await network.request(path: ApiEndPoint.Pizzas.catalog, method: .get, parameters: [:])
        return result
    }
}
