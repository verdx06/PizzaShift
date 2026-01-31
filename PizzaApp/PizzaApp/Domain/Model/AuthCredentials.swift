//
//  AuthCredentials.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

struct AuthCredentials: Codable {
    let phone: String
    let otpCode: String
}
