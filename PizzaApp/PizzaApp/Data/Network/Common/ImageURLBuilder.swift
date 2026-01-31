//
//  ImageURLBuilder.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

struct ImageURLBuilder {
    static func makeURL(path: String) -> URL? {
        guard path.isEmpty == false else { return nil }

        return URL(string: NetworkConfig.baseURL + path)
    }
}
