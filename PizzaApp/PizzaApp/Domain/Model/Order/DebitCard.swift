//
//  DebitCard.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

struct DebitCard: Codable, Hashable {
    let pan: String
    let expireDate: String
    let cvv: String
}
