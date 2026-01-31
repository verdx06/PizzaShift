//
//  MainCoordinatorView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation
import SwiftUI

struct MainCoordinatorView: View {
    private let homeCoordinator: HomeCoordinator
    private let bucketCoordinator: BucketCoordinator

    @ObservedObject
    private var mainCoordinator: MainCoordinator

    init(homeCoordinator: HomeCoordinator, bucketCoordinator: BucketCoordinator, mainCoordinator: MainCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.bucketCoordinator = bucketCoordinator
        self._mainCoordinator = ObservedObject(wrappedValue: mainCoordinator)
    }

    var body: some View {
        CustomTabView(selection: $mainCoordinator.selectedTab) { tab in
            switch tab {
            case .home:
                HomeCoordinatorView(coordinator: self.homeCoordinator)
            case .menu:
                Text("Меню")
            case .cart:
                BucketCoordinatorView(coordinator: bucketCoordinator)
            case .profile:
                Text("Профиль")
            }
        }
    }
}

enum MainTab: String, CaseIterable, Hashable {
    case home
    case menu
    case cart
    case profile

    var title: String {
        switch self {
        case .home:
            return "Пицца"
        case .menu:
            return "Заказы"
        case .cart:
            return "Корзина"
        case .profile:
            return "Профиль"
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "pizza"
        case .menu:
            return "order"
        case .cart:
            return "trash"
        case .profile:
            return "profile"
        }
    }

    var activeIcon: String {
        switch self {
        case .home:
            return "pizzaProfile"
        case .menu:
            return "orderActive"
        case .cart:
            return "trashActive"
        case .profile:
            return "profileActive"
        }
    }
}


