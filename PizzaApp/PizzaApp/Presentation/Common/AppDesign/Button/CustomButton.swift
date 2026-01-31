//
//  CustomButton.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color("brandColor"))
                .foregroundColor(.white)
                .cornerRadius(16)
        }
    }
}
