//
//  OrderModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

struct OrderModel: Codable, Hashable {
    let receiverAddress: ReceiverAddress
    let person: Person
    let debitCard: DebitCard
    let pizzas: [PizzaOrder]
}
