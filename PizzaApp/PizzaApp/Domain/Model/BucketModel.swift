//
//  BucketModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

struct BucketItem: Identifiable, Codable, Hashable {
    let id: String
    let pizza: PizzaModel
    let topings: [PizzaIngredient]
    let selectedSize: PizzaSize
    
    init(pizza: PizzaModel, topings: [PizzaIngredient], selectedSize: PizzaSize) {
        self.id = UUID().uuidString
        self.pizza = pizza
        self.topings = topings
        self.selectedSize = selectedSize
    }
}

struct BucketModel: Codable, Hashable {
    var buckets: [BucketItem]
    
    init(buckets: [BucketItem] = []) {
        self.buckets = buckets
    }
}
