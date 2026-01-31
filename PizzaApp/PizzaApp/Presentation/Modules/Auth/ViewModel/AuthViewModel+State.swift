//
//  AuthViewModel+State.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

extension AuthViewModel {
    enum State {
        case idle
        case otp
        case loading
        case signedIn

        var buttonTitle: String {
            switch self {
            case .idle:
                return "Продолжить"
            case .otp:
                return "Войти"
            case .loading:
                return "Загрузка"
            case .signedIn:
                return ""
            }
        }
    }
}
