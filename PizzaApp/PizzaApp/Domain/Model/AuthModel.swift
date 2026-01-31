//
//  AuthModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

struct AuthModel: Decodable {
    let success: Bool
    let user: UserInfo
    let token: String
}
