//
//  AppCoordinator.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

@MainActor
final class AppCoordinator: ObservableObject {
    enum Flow {
        case auth
        case main
        case loading
    }

    @Published var flow: Flow = .loading

    func routeToInitialFlow() async throws {
        self.flow = .loading

        if UserDefaults.standard.bool(forKey: "login") {
            self.showMainFlow()
        } else {
            self.showAuthFlow()
        }
    }
}

extension AppCoordinator {
    func showAuthFlow() {
        self.flow = .auth
    }
    
    func showMainFlow() {
        self.flow = .main
    }
}

