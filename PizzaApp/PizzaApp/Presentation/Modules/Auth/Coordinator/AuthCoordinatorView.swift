//
//  AuthCoordinatorView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct AuthCoordinatorView: View {
    @StateObject
    var authCoordinator: AuthCoordinator
    private let modularFactory: AuthCoordinatorFactory

    init(authCoordinator: AuthCoordinator, modularFactory: AuthCoordinatorFactory) {
        self._authCoordinator = StateObject(wrappedValue: authCoordinator)
        self.modularFactory = modularFactory
    }

    var body: some View {
        self.modularFactory.makeAuthView(coordinator: self.authCoordinator)
    }
}
