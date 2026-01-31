//
//  PizzaTopping.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct PizzaTopping: View {
    
    let url: URL?
    let type: String
    let price: Int
    let added: Bool
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                AsyncImage(url: self.url)
                    .frame(width: 88, height: 88)
                Text(self.type)
                    .font(.system(size: 12))
                    .padding(.top, 12)
                    .padding(.bottom, 4)
                Text("\(self.price) ₽")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
            }
        }
        .cornerRadius(16)
        .shadow(radius: 3)
        .frame(height: 172)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(added ? .blue : .clear)
        }
    }
}
