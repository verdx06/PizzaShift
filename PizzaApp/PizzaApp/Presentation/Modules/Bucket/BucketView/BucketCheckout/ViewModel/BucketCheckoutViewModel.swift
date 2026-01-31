//
//  BucketCheckoutViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

final class BucketCheckoutViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var city = ""
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func tapButton() {
        let data = CheckoutData(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            city: city
        )
        self.router.showNextHandler(data)
    }
    
}
