//
//  AuthViewModel.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    private let router: Router
    private let useCase: AuthUseCaseProtocol
    private(set) var state: State {
        didSet {
            let handler = onStateChange
            let currentState = state
            if Thread.isMainThread {
                handler?(currentState)
            } else {
                DispatchQueue.main.async {
                    handler?(currentState)
                }
            }
        }
    }
    var onStateChange: ((State) -> Void)?
    
    init(router: Router, useCase: AuthUseCaseProtocol) {
        self.state = .idle
        self.router = router
        self.useCase = useCase
    }
}
@MainActor
extension AuthViewModel {
    func buttonTapped(phone: String, code: String) {
        if self.state == .idle {
            self.sendOtpCode(phone: phone)
        }
        if self.state == .otp, let codeInt = Int(code) {
            self.signin(phone: phone, code: codeInt)
        }
    }
}

private extension AuthViewModel {
    func signin(phone: String, code: Int) {
        Task { @MainActor in
            self.state = .loading
            do {
                try await self.useCase.signin(credentials: AuthCredentials(phone: phone, otpCode: String(code)))
                UserDefaults.standard.set(true, forKey: "login")
                self.state = .signedIn
                self.router.showMainFlowHandler()
            } catch {
                #if DEBUG
                print("signin: \(error.localizedDescription)")
                #endif
                self.state = .idle
            }
        }
    }
    
    func sendOtpCode(phone: String) {
        Task { @MainActor in
            self.state = .loading
            do {
                try await self.useCase.sendOtpCode(phone: phone)
                self.state = .otp
            } catch {
                #if DEBUG
                print("otpError: \(error.localizedDescription)")
                #endif
                self.state = .idle
            }
        }
    }
}
