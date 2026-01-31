//
//  PizzaView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct PizzaView: View {
    
    let url: URL?
    let name: String
    let description: String
    let price: Int
    
    init(url: URL?, name: String, description: String, price: Int) {
        self.url = url
        self.name = name
        self.description = description
        self.price = price
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: self.url)
                .frame(width: 116, height: 116)
                .padding(.trailing, 24)
            VStack(alignment: .leading) {
                Text(self.name)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Text(self.description)
                    .foregroundStyle(.descriptionText)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8)
                Text("от \(self.price) ₽")
                    .fontWeight(.medium)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
    }
}
