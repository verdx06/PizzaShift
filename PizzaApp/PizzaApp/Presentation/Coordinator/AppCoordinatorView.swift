//
//  AppCoordinatorView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

@MainActor
struct AppCoordinatorView: View {
    @ObservedObject var appCoordinator: AppCoordinator
    private let moduleFactory: ModuleFactory
    private var authCoordinator: AuthCoordinator
    private let mainCoordinator: MainCoordinator

    init(appCoordinator: AppCoordinator, moduleFactory: ModuleFactory, authCoordinator: AuthCoordinator, mainCoordinator: MainCoordinator) {
        self.appCoordinator = appCoordinator
        self.moduleFactory = moduleFactory
        self.authCoordinator = authCoordinator
        self.mainCoordinator = mainCoordinator
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
            let homeCoordinator = HomeCoordinator(
                modularFactory: self.moduleFactory,
                showBucketHandler: {
                    self.mainCoordinator.showCartTab()
                }
            )
            let bucketCoordinator = BucketCoordinator(
                moduleFactory: self.moduleFactory,
                showHomeHandler: {
                    self.mainCoordinator.showHomeTab()
                    homeCoordinator.popToRoot()
                }
            )
            MainCoordinatorView(
                homeCoordinator: homeCoordinator,
                bucketCoordinator: bucketCoordinator,
                mainCoordinator: self.mainCoordinator
            )
        }
    }
}
