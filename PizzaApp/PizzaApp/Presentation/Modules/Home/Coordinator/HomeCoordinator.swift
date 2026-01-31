//
//  HomeCoordinator.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

@MainActor
final class HomeCoordinator: ObservableObject {
    enum Screen: Hashable {
        case home
        case detail(PizzaModel)
    }

    @Published var navigationPath: [Screen] = []
    private let moduleFactory: HomeCoordinatorFactory
    private let showBucketHandler: () -> Void

    init(modularFactory: HomeCoordinatorFactory, showBucketHandler: @escaping () -> Void) {
        self.moduleFactory = modularFactory
        self.showBucketHandler = showBucketHandler
    }

    func showDetail(pizza: PizzaModel) {
        navigationPath.append(.detail(pizza))
    }

    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func popToRoot() {
        navigationPath.removeAll()
    }

    func makeHomeView() -> HomeView {
        moduleFactory.makeHomeView(coordinator: self)
    }

    func makeDetailView(pizza: PizzaModel) -> DetailOrderView {
        moduleFactory.makeDetailOrderView(
            pizza: pizza,
            showBucketHandler: showBucketHandler
        )
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .home:
            makeHomeView()
        case .detail(let pizza):
            makeDetailView(pizza: pizza)
        }
    }
}
