//
//  BucketCheckoutView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import SwiftUI

struct BucketCheckoutView: View {
    
    @StateObject var viewModel: BucketCheckoutViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressLine(currentStep: 1, totalSteps: 2)
            
            VStack(alignment: .leading, spacing: 16) {
                FormFieldView(type: .lastName, text: $viewModel.lastName)
                FormFieldView(type: .firstName, text: $viewModel.firstName)
                FormFieldView(type: .phoneNumber, text: $viewModel.phoneNumber)
                FormFieldView(type: .email, text: $viewModel.email)
                FormFieldView(type: .city, text: $viewModel.city)
            }.padding(.top, 16)
            Spacer()
            
            CustomButton(title: "Продолжить") {
                self.viewModel.tapButton()
            }
        }
        .padding(.horizontal, 16)
        .backButton(title: "Ваши данные")
    }
}
