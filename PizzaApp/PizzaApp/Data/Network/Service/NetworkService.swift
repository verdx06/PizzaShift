//
//  NetworkService.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func sendOtpCode(phone: String) async throws
    func signin(credentials: AuthCredentials) async throws
    func getCatalog() async throws -> PizzaCatalogResponse
}

final class NetworkService {
    private let baseNetwork: BaseNetworkProtocol
    
    init(baseNetwork: BaseNetworkProtocol) {
        self.baseNetwork = baseNetwork
    }
}

extension NetworkService: NetworkServiceProtocol {
    func signin(credentials: AuthCredentials) async throws {
        let result: AuthModel = try await baseNetwork.request(
            path: ApiEndPoint.Auth.signin,
            method: .post,
            parameters: [
                "phone": credentials.phone,
                "code": credentials.otpCode
            ]
        )
        UserDefaults.standard.set(result.token, forKey: "token")
    }
    
    func sendOtpCode(phone: String) async throws {
        try await baseNetwork.request(
            path: ApiEndPoint.Auth.otp,
            method: .post,
            parameters: ["phone": phone]
        )
    }
    
    func getCatalog() async throws -> PizzaCatalogResponse {
        try await baseNetwork.request(
            path: .pizzasCatalog,
            method: .get,
            parameters: nil
        )
    }
}
