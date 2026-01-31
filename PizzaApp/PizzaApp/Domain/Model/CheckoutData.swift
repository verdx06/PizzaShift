//
//  CheckoutData.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

struct CheckoutData: Hashable {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let email: String
    let city: String
}

extension CheckoutData {
    static var empty: CheckoutData {
        CheckoutData(firstName: "", lastName: "", phoneNumber: "", email: "", city: "")
    }
}
