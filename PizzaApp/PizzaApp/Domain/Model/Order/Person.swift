//
//  Person.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

struct Person: Codable, Hashable {
    let firstname: String
    let lastname: String
    let middlename: String
    let phone: String
}
