//
//  BucketCoordinator.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation
import SwiftUI

@MainActor
final class BucketCoordinator: ObservableObject {
    enum Screen: Hashable {
        case bucket
        case checkout
        case payment
        case success
    }

    @Published var navigationPath: [Screen] = []
    @Published var isCheckoutPresented = false
    private let moduleFactory: BucketCoordinatorFactory
    private let showHomeHandler: () -> Void
    private var checkoutData: CheckoutData?
    
    init(moduleFactory: BucketCoordinatorFactory, showHomeHandler: @escaping () -> Void) {
        self.moduleFactory = moduleFactory
        self.showHomeHandler = showHomeHandler
    }
    
    func showCheckout() {
        withAnimation(.easeInOut) {
            isCheckoutPresented = true
            navigationPath = [.checkout]
        }
    }
    
    func showPayment(data: CheckoutData) {
        checkoutData = data
        withAnimation(.easeInOut) {
            navigationPath.append(.payment)
        }
    }
    
    func showSuccess() {
        withAnimation(.easeInOut) {
            navigationPath.append(.success)
        }
    }

    func showHome() {
        showHomeHandler()
        dismissCheckout()
    }
    
    func popToRoot() {
        withAnimation(.easeInOut) {
            navigationPath.removeAll()
        }
    }
    
    func pop() {
        if !navigationPath.isEmpty {
            withAnimation(.easeInOut) {
                navigationPath.removeLast()
            }
        }
    }

    func dismissCheckout() {
        withAnimation(.easeInOut) {
            isCheckoutPresented = false
            navigationPath.removeAll()
        }
    }
    
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .bucket:
            moduleFactory.makeBucketView(coordinator: self)
        case .checkout:
            moduleFactory.makeBucketCheckoutView(coordinator: self)
        case .payment:
            moduleFactory.makeBucketPaymentView(
                coordinator: self,
                checkoutData: checkoutData ?? .empty
            )
        case .success:
            moduleFactory.makeBucketSuccessView(coordinator: self)
        }
    }
}
