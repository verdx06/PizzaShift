//
//  AuthViewContainer.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import SwiftUI
import UIKit

struct AuthViewContainer: UIViewControllerRepresentable {
    let viewModel: AuthViewModel

    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = ViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
