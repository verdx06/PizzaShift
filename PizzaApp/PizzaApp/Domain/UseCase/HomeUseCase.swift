//
//  HomeUseCase.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getPizzas() async throws -> PizzaCatalogResponse
}

final class HomeUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeUseCase: HomeUseCaseProtocol {
    func getPizzas() async throws -> PizzaCatalogResponse {
        return try await self.repository.getPizzas()
    }
}
