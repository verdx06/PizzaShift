//
//  CoordinatorFactoryProtocols.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

typealias AuthCoordinatorFactory = AuthViewFactory
typealias HomeCoordinatorFactory = HomeViewFactory & DetailOrderViewFactory
typealias BucketCoordinatorFactory = BucketViewFactory & BucketPaymentFactory & BucketCheckoutFactory & BucketSuccessFactory
