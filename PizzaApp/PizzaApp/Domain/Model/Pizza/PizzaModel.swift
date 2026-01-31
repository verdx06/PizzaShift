//
//  PizzaModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

struct PizzaModel: Codable, Hashable {
    let id: String
    let name: String
    let ingredients: [PizzaIngredient]
    let toppings: [PizzaIngredient]
    let description: String
    let sizes: [PizzaSize]
    let doughs: [PizzaDough]
    let calories: Int
    let protein: String
    let totalFat: String
    let carbohydrates: String
    let sodium: String
    let allergens: [String]
    let isVegetarian: Bool
    let isGlutenFree: Bool
    let isNew: Bool
    let isHit: Bool
    let img: String
}

extension PizzaModel {
    static var empty: PizzaModel {
        PizzaModel(
            id: "",
            name: "",
            ingredients: [],
            toppings: [],
            description: "",
            sizes: [],
            doughs: [],
            calories: 0,
            protein: "",
            totalFat: "",
            carbohydrates: "",
            sodium: "",
            allergens: [],
            isVegetarian: false,
            isGlutenFree: false,
            isNew: false,
            isHit: false,
            img: ""
        )
    }
}
