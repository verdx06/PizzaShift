//
//  AppCoordinatorView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct AppCoordinatorView: View {
    @ObservedObject var appCoordinator: AppCoordinator
    private let moduleFactory: ModuleFactory
    private var authCoordinator: AuthCoordinator

    init(appCoordinator: AppCoordinator, moduleFactory: ModuleFactory, authCoordinator: AuthCoordinator) {
        self.appCoordinator = appCoordinator
        self.moduleFactory = moduleFactory
        self.authCoordinator = authCoordinator
    }

    var body: some View {
        scene
            .animation(.default, value: self.appCoordinator.flow)
            .task {
                try? await self.appCoordinator.routeToInitialFlow()
            }
    }
}

extension AppCoordinatorView {
    @ViewBuilder
    var scene: some View {
        switch self.appCoordinator.flow {
        case .loading:
            ProgressView()
        case .auth:
            AuthCoordinatorView(
                authCoordinator: self.authCoordinator,
                modularFactory: self.moduleFactory
            )
        case .main:
            MainCoordinatorView(
                homeCoordinator: HomeCoordinator(modularFactory: self.moduleFactory),
                mainCoordinator: MainCoordinator()
            )
        }
    }
}
