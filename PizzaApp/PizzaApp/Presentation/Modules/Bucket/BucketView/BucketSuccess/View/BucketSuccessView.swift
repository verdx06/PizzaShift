//
//  BucketSuccessView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import SwiftUI

struct BucketSuccessView: View {
    
    @StateObject var viewModel: BucketSuccessViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image("success")
            Text("Оплата прошла успешно!")
                .font(.system(size: 24, weight: .bold))
            Spacer(minLength: 420)
            CustomButton(title: "На главную") {
                self.viewModel.tapButton()
            }
            Spacer()
        }.navigationBarBackButtonHidden()
        .padding()
    }
}
