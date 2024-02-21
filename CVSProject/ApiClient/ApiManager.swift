//
//  ApiManager.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import Foundation

protocol ApiManagerContract {
    func restApi<T: Decodable>(_ request: Requestable, type: T.Type) async throws -> T
}

struct ApiManager {
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension ApiManager: ApiManagerContract, JsonDecoder {
    func restApi<T>(_ request: Requestable, type: T.Type) async throws -> T where T : Decodable {
        guard let urlRequest = request.createUrlRequest() else {
            throw ApiCallError.invalidRequest
        }
        let (data, response) = try await urlSession.data(for: urlRequest, delegate: nil)
        if  response.isValidResponse() {
            return try decode(type:type, data: data)
        } else {
            throw ApiCallError.invalidResponse
        }
    }
}

extension URLResponse {
    func isValidResponse()-> Bool {
        guard let response = self as? HTTPURLResponse else {
            return false
        }
        switch response.statusCode {
        case 200...299:
          return true
        default:
          return false
        }
    }
}
