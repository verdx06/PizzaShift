//
//  SegmentedControl.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import SwiftUI

struct SegmentedControl<Item: Hashable>: View {
    let items: [Item]
    @Binding var selection: Item
    let title: (Item) -> String
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element) { index, item in
                Button(action: {
                    selection = item
                }) {
                    Text(title(item))
                        .font(.system(size: 14))
                        .foregroundColor(selection == item ? .primary : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            selection == item ? Color.white : Color.clear
                        )
                        .cornerRadius(8)
                }
            }
        }
        .padding(4)
        .background(Color("bgsecodnary"))
        .cornerRadius(12)
    }
}
