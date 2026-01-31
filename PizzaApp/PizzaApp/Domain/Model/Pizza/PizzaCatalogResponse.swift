//
//  PizzaCatalogResponse.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

struct PizzaCatalogResponse: Codable, Hashable {
    let success: Bool
    let catalog: [PizzaModel]
}

extension PizzaCatalogResponse {
    static let empty = PizzaCatalogResponse(
        success: false,
        catalog: []
    )
}
