//
//  ModuleFactoryProtocols.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

@MainActor
protocol AuthViewFactory: AnyObject {
    func makeAuthView(coordinator: AuthCoordinator) -> AuthViewContainer
}

@MainActor
protocol HomeViewFactory: AnyObject {
    func makeHomeView(coordinator: HomeCoordinator) -> HomeView
}

@MainActor
protocol DetailOrderViewFactory: AnyObject {
    func makeDetailOrderView(pizza: PizzaModel, showBucketHandler: @escaping () -> Void) -> DetailOrderView
}

@MainActor
protocol BucketViewFactory: AnyObject {
    func makeBucketView(coordinator: BucketCoordinator) -> BucketView
}

@MainActor
protocol BucketPaymentFactory: AnyObject {
    func makeBucketPaymentView(coordinator: BucketCoordinator, checkoutData: CheckoutData) -> BucketPaymentView
}

@MainActor
protocol BucketCheckoutFactory: AnyObject {
    func makeBucketCheckoutView(coordinator: BucketCoordinator) -> BucketCheckoutView
}

@MainActor
protocol BucketSuccessFactory: AnyObject {
    func makeBucketSuccessView(coordinator: BucketCoordinator) -> BucketSuccessView
}
