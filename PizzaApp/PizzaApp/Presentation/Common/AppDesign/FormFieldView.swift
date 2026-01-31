//
//  FormFieldView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import SwiftUI

struct FormFieldView: View {
    let type: FieldType
    @Binding var text: String
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 2) {
                Text(type.title)
                    .font(.system(size: 14))
                if type.isRequired {
                    Text("*")
                        .font(.system(size: 14))
                }
            }
            
            switch type {
            case .firstName, .lastName, .phoneNumber, .email, .city, .cardNumber:
                self.defualtField
            case .cardExpiry, .cardCVV:
                self.smallField
            }
        }
    }
}

extension FormFieldView {
    @ViewBuilder
    var defualtField: some View {
        TextField(placeholder, text: $text)
            .keyboardType(type.keyboardType)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color.white)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderlight, lineWidth: 2)
            }
    }
    @ViewBuilder
    var smallField: some View {
        TextField(placeholder, text: $text)
            .keyboardType(type.keyboardType)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color.white)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderlight, lineWidth: 2)
            }
    }
}

#Preview {
    FormFieldView(type: .city, text: .constant(""))
}
