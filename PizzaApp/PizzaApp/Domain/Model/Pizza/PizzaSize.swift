//
//  PizzaSize.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

struct PizzaSize: Codable, Hashable {
    let type: SizeType
    let price: Int
}

extension PizzaSize {
    static var empty = PizzaSize(type: .small, price: 0)
}
