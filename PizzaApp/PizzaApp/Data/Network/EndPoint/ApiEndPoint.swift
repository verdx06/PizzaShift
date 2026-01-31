//
//  ApiEndPoint.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

enum ApiEndPoint {
    case authOtp
    case usersSignIn
    case usersSession
    case usersProfileUpdate
    case pizzasCatalog
    case pizzasPayment
    case pizzasOrders
    case pizzasOrder(id: String)
    case pizzasOrderCancel
}

extension ApiEndPoint {
    var path: String {
        switch self {
        case .authOtp:
            return "/auth/otp"
        case .usersSignIn:
            return "/users/signin"
        case .usersSession:
            return "/users/session"
        case .usersProfileUpdate:
            return "/users/profile"
        case .pizzasCatalog:
            return "/pizzas/catalog"
        case .pizzasPayment:
            return "/pizzas/payment"
        case .pizzasOrders:
            return "/pizzas/orders"
        case .pizzasOrder(let id):
            return "/pizzas/orders/\(id)"
        case .pizzasOrderCancel:
            return "/pizzas/order/cancel"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .authOtp:
            return .post
        case .usersSignIn:
            return .post
        case .usersSession:
            return .post
        case .usersProfileUpdate:
            return .patch
        case .pizzasCatalog:
            return .get
        case .pizzasPayment:
            return .post
        case .pizzasOrders:
            return .get
        case .pizzasOrder:
            return .get
        case .pizzasOrderCancel:
            return .put
        }
    }
}

extension ApiEndPoint {
    enum Auth {
        static let otp = ApiEndPoint.authOtp
        static let signin = ApiEndPoint.usersSignIn
    }
}
