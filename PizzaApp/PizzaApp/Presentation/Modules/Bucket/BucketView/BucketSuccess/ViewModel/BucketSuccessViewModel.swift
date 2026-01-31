//
//  BucketSuccessViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

final class BucketSuccessViewModel: ObservableObject {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func tapButton() {
        self.router.showDoneHandler()
    }
    
}
