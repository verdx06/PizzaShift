//
//  HomeViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    private let router: Router
    private let useCase: HomeUseCaseProtocol
    @Published private(set) var pizzaCatalog: PizzaCatalogResponse
    @Published private(set) var state: State
    
    init(router: Router, useCase: HomeUseCaseProtocol) {
        self.state = .loaded
        self.router = router
        self.useCase = useCase
        self.pizzaCatalog = .empty
    }
    
}

extension HomeViewModel {
    func getPizzas() {
        Task {
            await MainActor.run {
                self.state = .loading
            }
            do {
                let result = try await self.useCase.getPizzas()
                await MainActor.run {
                    self.pizzaCatalog = result
                    self.state = result.catalog.isEmpty ? .empty : .loaded
                }
            } catch {
                await MainActor.run {
                    self.state = .empty
                }
                print(error.localizedDescription)
            }
        }
    }

    func selectPizza(_ pizza: PizzaModel) {
        router.showDetailHandler(pizza)
    }
}

