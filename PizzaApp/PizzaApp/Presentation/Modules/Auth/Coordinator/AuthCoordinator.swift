//
//  AuthCoordinator.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

@MainActor
final class AuthCoordinator: ObservableObject {
    private let showMainFlowHandler: () -> Void

    init(showMainFlowHandler: @escaping () -> Void) {
        self.showMainFlowHandler = showMainFlowHandler
    }

    func showMainFlow() {
        showMainFlowHandler()
    }
}
