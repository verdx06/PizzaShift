//
//  ModuleFactory.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation
import SwiftUI

@MainActor
final class ModuleFactory {
    private let useCaseFactory: UseCaseFactory

    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
}

extension ModuleFactory: AuthViewFactory {
    func makeAuthView(coordinator: AuthCoordinator) -> AuthViewContainer {
        let router = AuthViewModel.Router(
            showMainFlowHandler: { coordinator.showMainFlow() }
        )
        let viewModel = AuthViewModel(
            router: router,
            useCase: self.useCaseFactory.makeAuthUseCase()
        )
        return AuthViewContainer(viewModel: viewModel)
    }
}

extension ModuleFactory: HomeViewFactory {
    func makeHomeView(coordinator: HomeCoordinator) -> HomeView {
        let router = HomeViewModel.Router(
            showDetailHandler: { coordinator.showDetail(pizza: $0) }
        )
        let viewModel = HomeViewModel(
            router: router,
            useCase: self.useCaseFactory.makeHomeUseCase()
        )
        return HomeView(viewModel: viewModel)
    }
}

extension ModuleFactory: DetailOrderViewFactory {
    func makeDetailOrderView(pizza: PizzaModel, showBucketHandler: @escaping () -> Void) -> DetailOrderView {
        let router = DetailOrderViewModel.Router(
            showBucketHandler: showBucketHandler
        )
        let viewModel = DetailOrderViewModel(
            pizza: pizza,
            useCase: self.useCaseFactory.makeDetailOrderUseCase(),
            router: router
        )
        return DetailOrderView(viewModel: viewModel)
    }
}

extension ModuleFactory: BucketViewFactory {
    func makeBucketView(coordinator: BucketCoordinator) -> BucketView {
        let router = BucketViewModel.Router(
            showCheckoutHandler: { coordinator.showCheckout() }
        )
        let viewModel = BucketViewModel(
            router: router,
            useCase: self.useCaseFactory.makeBucketUseCase()
        )
        return BucketView(viewModel: viewModel)
    }
}

extension ModuleFactory: BucketPaymentFactory {
    func makeBucketPaymentView(coordinator: BucketCoordinator, checkoutData: CheckoutData) -> BucketPaymentView {
        let useCase = self.useCaseFactory.makeBucketUseCase()
        let router = BucketPaymentViewModel.Router {
            coordinator.showSuccess()
        }
        let viewModel = BucketPaymentViewModel(
            checkoutData: checkoutData,
            useCase: useCase,
            router: router
        )
        return BucketPaymentView(viewModel: viewModel)
    }
}

extension ModuleFactory: BucketCheckoutFactory {
    func makeBucketCheckoutView(coordinator: BucketCoordinator) -> BucketCheckoutView {
        let router = BucketCheckoutViewModel.Router { data in
            coordinator.showPayment(data: data)
        }
        let viewModel = BucketCheckoutViewModel(router: router)
        return BucketCheckoutView(viewModel: viewModel)
    }
}


extension ModuleFactory: BucketSuccessFactory {
    func makeBucketSuccessView(coordinator: BucketCoordinator) -> BucketSuccessView {
        let router = BucketSuccessViewModel.Router { coordinator.showHome() }
        let viewModel = BucketSuccessViewModel(router: router)
        return BucketSuccessView(viewModel: viewModel)
    }
}
