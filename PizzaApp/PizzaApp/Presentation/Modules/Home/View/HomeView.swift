//
//  HomeView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        scene
            .navigationTitle("Пицца")
            .onAppear {
                viewModel.getPizzas()
            }
    }
}

private extension HomeView {
    @ViewBuilder
    var scene: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .empty:
            VStack {
                Spacer()
                Text("Пицц нет")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
        case .loaded:
            ScrollView {
                ForEach(self.viewModel.pizzaCatalog.catalog, id: \.self) { pizza in
                    Button {
                        viewModel.selectPizza(pizza)
                    } label: {
                        PizzaView(
                            url: ImageURLBuilder.makeURL(path: pizza.img),
                            name: pizza.name,
                            description: pizza.description,
                            price: pizza.sizes.first?.price ?? 0
                        ).padding()
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
