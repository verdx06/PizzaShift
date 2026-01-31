//
//  AuthRepository.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

protocol AuthRepositoryProtocol {
    func sendOtpCode(phone: String) async throws
    func signin(credentials: AuthCredentials) async throws
}

final class AuthRepository
{
    private let network: BaseNetworkProtocol
    
    init(network: BaseNetworkProtocol) {
        self.network = network
    }
}

extension AuthRepository: AuthRepositoryProtocol {
    func signin(credentials: AuthCredentials) async throws {
        let result: AuthModel = try await network.request(
            path: ApiEndPoint.Auth.signin,
            method: .post,
            parameters: [
                "phone": credentials.phone,
                "code": credentials.otpCode
            ]
        )
        UserDefaults.standard.set(result.token, forKey: "token")
        UserDefaults.standard.set(result.success, forKey: "login")
    }
    
    func sendOtpCode(phone: String) async throws {
        try await network.request(
            path: ApiEndPoint.Auth.otp,
            method: .post,
            parameters: ["phone": phone]
        )
    }
}
