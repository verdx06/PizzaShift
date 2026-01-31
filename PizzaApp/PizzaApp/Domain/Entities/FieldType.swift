//
//  FieldType.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import SwiftUI

enum FieldType: Hashable {
    case firstName
    case lastName
    case phoneNumber
    case email
    case city
    case cardNumber
    case cardExpiry
    case cardCVV
}

extension FieldType {
    var title: String {
        switch self {
        case .firstName:
            return "Имя"
        case .lastName:
            return "Фамилия"
        case .phoneNumber:
            return "Номер телефона"
        case .email:
            return "Email"
        case .city:
            return "Город"
        case .cardNumber:
            return "Номер"
        case .cardExpiry:
            return "Срок"
        case .cardCVV:
            return "CVV"
        }
    }
    
    var isRequired: Bool {
        switch self {
        case .firstName,
             .lastName,
             .phoneNumber,
             .email,
             .city,
             .cardNumber,
             .cardExpiry,
             .cardCVV:
            return true
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .phoneNumber:
            return .phonePad
        case .cardNumber, .cardExpiry, .cardCVV:
            return .numberPad
        default:
            return .default
        }
    }
}
