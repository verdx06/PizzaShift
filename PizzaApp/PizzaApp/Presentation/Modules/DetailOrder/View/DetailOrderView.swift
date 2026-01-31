//
//  DetailOrderView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct DetailOrderView: View {
    
    @StateObject var viewModel: DetailOrderViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        AsyncImage(url: ImageURLBuilder.makeURL(path: self.viewModel.pizza.img))
                            .frame(width: 220, height: 220)
                        Spacer()
                    }
                    Text(self.viewModel.pizza.name)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .padding(.top, 32)
                    Text("30 см, традиционное тесто")
                        .font(.system(size: 14))
                        .foregroundStyle(.descriptionText)
                        .padding(.vertical, 8)
                    Text(self.viewModel.pizza.description)
                        .font(.system(size: 16))
                        .foregroundStyle(.descriptionText)
                        .padding(.bottom, 24)
                    SegmentedControl(
                        items: self.viewModel.pizza.sizes,
                        selection: $viewModel.selectedSize,
                        title: { size in
                            switch size.type {
                            case .small:
                                return "Маленькая"
                            case .medium:
                                return "Средняя"
                            case .large:
                                return "Большая"
                            }
                        }
                    )
                    .padding(.bottom, 24)
                    Text("Добавить по вкусу")
                        .font(.headline)
                        .padding(.bottom, 16)
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(self.viewModel.pizza.toppings, id: \.type) { topping in
                            Button {
                                self.viewModel.tapIngredientAndUpdateSum(topping: topping)
                            } label: {
                                PizzaTopping(
                                    url: ImageURLBuilder.makeURL(path: topping.img),
                                    type: topping.type,
                                    price: topping.price,
                                    added: self.viewModel.additionalIngredients.contains(where: { $0.type == topping.type })
                                ).foregroundStyle(.black)
                            }
                        }
                    }
                    Spacer()
                }
                .backButton(title: "Пицца")
                .padding()
            }
            CustomButton(title: "Добавить в корзину за \(self.viewModel.totalSum) ₽") {
                self.viewModel.tapDesignOrder()
            }.padding(.bottom, 45)
        }
    }
}
