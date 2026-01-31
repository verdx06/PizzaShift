//
//  BaseNetwork.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import Foundation
import Alamofire
import Security

protocol BaseNetworkProtocol {
    func request(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) async throws
    func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) async throws -> T
}

final class BaseNetwork: BaseNetworkProtocol
{
    private let headers: HTTPHeaders = [
            HeaderConstants.contentTypeHeader: HeaderConstants.jsonContentType
        ]
    private let baseURL = NetworkConfig.baseURL
    private let session: Session

    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.tlsMinimumSupportedProtocolVersion = .TLSv10
        let evaluators: [String: ServerTrustEvaluating] = [
            "shift-intensive.ru": DisabledTrustEvaluator()
        ]
        let serverTrustManager = ServerTrustManager(
            allHostsMustBeEvaluated: false,
            evaluators: evaluators
        )
        self.session = Session(
            configuration: configuration,
            serverTrustManager: serverTrustManager
        )
    }

    func request(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) async throws {
        let url = "\(self.baseURL)\(path)"

        _ = try await session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding(for: method),
            headers: self.headers
        )
        .validate()
        .serializingData()
        .value
    }

    func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) async throws -> T {
        let url = "\(self.baseURL)\(path)"
        #if DEBUG
        print(url)
        #endif
        let response = try await session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding(for: method),
            headers: self.headers
        )
        .validate()
        .serializingDecodable(T.self)
        .value
        
        return response
    }
}

private extension BaseNetwork {

    func encoding(for method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post, .patch, .put:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    enum HeaderConstants {
        static let jsonContentType = "application/json"
        static let contentTypeHeader = "Content-Type"
    }
}
