//
//  MainTab.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

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

extension MainTab {
    var coordinatorTab: MainCoordinator.Tab {
        switch self {
        case .home:
            return .home
        case .menu:
            return .menu
        case .cart:
            return .cart
        case .profile:
            return .profile
        }
    }
}

extension MainCoordinator.Tab {
    var mainTab: MainTab {
        switch self {
        case .home:
            return .home
        case .menu:
            return .menu
        case .cart:
            return .cart
        case .profile:
            return .profile
        }
    }
}
