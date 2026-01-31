//
//  Path.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

enum ApiEndPoint {
    enum Auth {
        static let otp = "/auth/otp"
        static let signin = "/users/signin"
        static let session = "/auth/session"
    }

    enum Users {
        static let profile = "/users/profile"
    }

    enum Pizzas {
        static let catalog = "/pizza/catalog"
        static let payment = "/pizza/payment"
        static let orders = "/pizza/orders"
        static let cancelOrder = "/pizza/order/cancel"

        static func order(_ orderId: String) -> String {
            orders + "/\(orderId)"
        }
    }
}
