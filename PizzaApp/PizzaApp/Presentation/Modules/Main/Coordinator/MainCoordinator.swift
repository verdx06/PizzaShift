//
//  MainCoordinator.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

final class MainCoordinator: ObservableObject {

    @Published
    var selectedTab: MainTab = .home
    
    func showHomeTab() {
        self.selectedTab = .home
    }

    func showCartTab() {
        self.selectedTab = .cart
    }
}
