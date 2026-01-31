//
//  UIColor+Brand.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import UIKit
import SwiftUI

extension UIColor {
    static var brand: UIColor {
        UIColor(named: "brandColor") ?? .systemBlue
    }
}

extension Color {
    static var borderlight: Color {
        Color.gray.opacity(0.3)
    }
}
