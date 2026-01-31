//
//  PizzaIngredient.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

struct PizzaIngredient: Codable, Hashable {
    let type: String
    let price: Int
    let img: String
}
