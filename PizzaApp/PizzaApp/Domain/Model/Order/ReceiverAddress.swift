//
//  ReceiverAddress.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

struct ReceiverAddress: Codable, Hashable {
    let street: String
    let house: String
    let apartment: String
    let comment: String
}
