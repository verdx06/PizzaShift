//
//  BucketCoordinatorView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct BucketCoordinatorView: View {
    @ObservedObject
    private var coordinator: BucketCoordinator
    
    init(coordinator: BucketCoordinator) {
        self._coordinator = ObservedObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        NavigationView {
            coordinator.build(screen: .bucket)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $coordinator.isCheckoutPresented, onDismiss: {
            coordinator.dismissCheckout()
        }) {
            BucketCheckoutFlowView(coordinator: coordinator)
        }
    }
}

private struct BucketCheckoutFlowView: View {
    @ObservedObject
    private var coordinator: BucketCoordinator
    
    init(coordinator: BucketCoordinator) {
        self._coordinator = ObservedObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationView {
            ZStack {
                coordinator.build(screen: .checkout)
                NavigationLink(
                    destination: paymentDestination,
                    isActive: isActive(count: 2)
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension BucketCheckoutFlowView {
    @ViewBuilder
    var paymentDestination: some View {
        coordinator.build(screen: .payment)
            .background(
                NavigationLink(
                    destination: successDestination,
                    isActive: isActive(count: 3)
                ) {
                    EmptyView()
                }
                .hidden()
            )
    }
    
    @ViewBuilder
    var successDestination: some View {
        coordinator.build(screen: .success)
    }
    
    func isActive(count: Int) -> Binding<Bool> {
        Binding(
            get: { coordinator.navigationPath.count >= count },
            set: { isActive in
                if !isActive {
                    let newCount = max(count - 1, 0)
                    coordinator.navigationPath = Array(coordinator.navigationPath.prefix(newCount))
                }
            }
        )
    }
}
