//
//  BucketView.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI

struct BucketView: View {
    
    @StateObject var viewModel: BucketViewModel
    
    var body: some View {
        scene
        .backButton(title: "Корзина")
        .onAppear {
            viewModel.loadBucket()
        }
    }
}

private extension BucketView {
    @ViewBuilder
    var scene: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .empty:
            VStack {
                Spacer()
                Text("Корзина пуста")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
        case .loaded:
            loadedView
        }
    }

    var loadedView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.top, 24)
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.bucket.buckets, id: \.id) { item in
                            HStack(alignment: .top, spacing: 16) {
                                AsyncImage(url: ImageURLBuilder.makeURL(path: item.pizza.img)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.pizza.name)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.primary)

                                    Text(viewModel.formatPizzaDescription(item: item))
                                        .font(.system(size: 12))
                                        .foregroundStyle(.descriptionText)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)

                                    HStack(spacing: 16) {
                                        HStack(spacing: 0) {
                                            Button(action: {}) {
                                                Text("-")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.primary)
                                                    .frame(width: 24, height: 24)
                                            }

                                            Text("1")
                                                .font(.system(size: 16))
                                                .foregroundColor(.primary)
                                                .frame(minWidth: 20)

                                            Button(action: {}) {
                                                Text("+")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.primary)
                                                    .frame(width: 24, height: 24)
                                            }
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color("bgsecodnary"))
                                        .cornerRadius(20)

                                        // Кнопка "Изменить"
                                        Button(action: {}) {
                                            VStack(spacing: 0) {
                                                Text("Изменить")
                                                    .font(.system(size: 12))
                                                    .foregroundStyle(.content06)
                                                Rectangle()
                                                    .foregroundStyle(.content06)
                                                    .frame(height: 1)
                                            }
                                        }

                                        Spacer()

                                        // Цена
                                        Text("\(item.selectedSize.price + item.topings.reduce(0) { $0 + $1.price }) ₽")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                }

                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)

                            Divider()
                        }
                    }
                    .padding(.bottom, 120) // Отступ для sticky footer
                }
            }

            // Sticky Footer
            if !viewModel.bucket.buckets.isEmpty {
                VStack(spacing: 0) {
                    VStack(spacing: 12) {
                        HStack {
                            Text("Стоимость заказа:")
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(viewModel.totalPrice) ₽")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 16)

                        Button(action: {
                            viewModel.tapCheckout()
                        }) {
                            Text("Оформить заказ")
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color("brandColor"))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .background(
                        Color.white
                            .clipShape(
                                RoundedCorner(radius: 16, corners: [.topLeft, .topRight])
                            )
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -4)
                    )
                }.padding(.bottom, 42)
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    NavigationView {
        BucketView(
            viewModel: BucketViewModel(
                router: BucketViewModel.Router(showCheckoutHandler: {}),
                useCase: BucketUseCase(repository: BucketRepository(network: BaseNetwork()))
            )
        )
    }
}
