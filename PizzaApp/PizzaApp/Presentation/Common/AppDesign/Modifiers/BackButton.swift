//
//  BackButton.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct BackButton: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let title: String?
    
    init(title: String? = nil) {
        self.title = title
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("ArrowBack")
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }.padding(.top, 8)
                    .buttonStyle(PlainButtonStyle())
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if let title = title {
                        HStack {
                            Spacer()
                            Text(title)
                                .font(.system(size: 28, weight: .bold))
                        }.padding(.top, 8)
                    }
                }
            })
    }
}

extension View {
    func backButton(title: String? = nil) -> some View {
        modifier(BackButton(title: title))
    }
}
