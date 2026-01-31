//
//  BucketPaymentView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import SwiftUI

struct BucketPaymentView: View {
    
    @StateObject var viewModel: BucketPaymentViewModel
    
    var body: some View {
        VStack {
            ProgressLine(currentStep: 2, totalSteps: 2)
            ZStack() {
                RoundedRectangle(cornerRadius: 15)
                    .frame(maxWidth: .infinity)
                    .frame(height: 212)
                    .foregroundStyle(.bgprimary)
                VStack {
                    FormFieldView(type: .cardNumber, text: $viewModel.cardNumber)
                        .padding(.horizontal, 12)
                    HStack{
                        FormFieldView(type: .cardExpiry, text: $viewModel.cardExpiry)
                            .padding(.horizontal, 12)
                        Spacer()
                        FormFieldView(type: .cardCVV, text: $viewModel.cardCVV)
                            .padding(.horizontal, 12)
                    }.padding(.top, 16)
                } .padding(.horizontal, 12)
            }.padding(.top, 24)
            
            CustomButton(title: "Оплатить") {
                self.viewModel.tapButton()
            }.padding(.top, 24)
            
            Spacer()
        }
        .padding(.horizontal)
        .backButton(title: "Карта оплаты")
    }
}

#Preview {
    ModuleFactory(useCaseFactory: UseCaseFactory(repositoryFactory: RepositoryFactory()))
        .makeBucketPaymentView(
            coordinator: BucketCoordinator(
                moduleFactory: ModuleFactory(useCaseFactory: UseCaseFactory(repositoryFactory: RepositoryFactory())),
                showHomeHandler: {}
            ),
            checkoutData: .empty
        )
}
