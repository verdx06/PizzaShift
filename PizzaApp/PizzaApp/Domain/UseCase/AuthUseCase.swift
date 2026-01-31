//
//  AuthUseCase.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation

protocol AuthUseCaseProtocol {
    func sendOtpCode(phone: String) async throws
    func signin(credentials: AuthCredentials) async throws
}

final class AuthUseCase: AuthUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func sendOtpCode(phone: String) async throws {
        try await repository.sendOtpCode(phone: phone)
    }
    
    func signin(credentials: AuthCredentials) async throws {
        try await repository.signin(credentials: credentials)
    }
}
