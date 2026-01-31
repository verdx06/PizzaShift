//
//  BucketViewModel+Router.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import Foundation

extension BucketViewModel {
    struct Router {
        let showCheckoutHandler: () -> Void
    }

    enum State {
        case loading
        case loaded
        case empty
    }
}
