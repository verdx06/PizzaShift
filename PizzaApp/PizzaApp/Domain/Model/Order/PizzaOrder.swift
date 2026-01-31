//
//  PizzaOrder.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

struct PizzaOrder: Codable, Hashable {
    let id: String
    let toppings: [String]
    let size: SizeType
    let dough: String
}
