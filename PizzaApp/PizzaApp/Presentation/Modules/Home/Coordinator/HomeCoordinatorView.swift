//
//  HomeCoordinatorView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject
    private var coordinator: HomeCoordinator

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            ZStack {
                coordinator.build(screen: .home)
                NavigationLink(
                    destination: destination,
                    isActive: self.isActive
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension HomeCoordinatorView {
    @ViewBuilder
    var destination: some View {
        if let screen = coordinator.navigationPath.last {
            coordinator.build(screen: screen)
        } else {
            EmptyView()
        }
    }
    
    var isActive: Binding<Bool> {
        Binding (
            get: { !coordinator.navigationPath.isEmpty },
            set: { isActive in
                if isActive == false {
                    coordinator.pop()
                }
            }
        )
    }
    
}
