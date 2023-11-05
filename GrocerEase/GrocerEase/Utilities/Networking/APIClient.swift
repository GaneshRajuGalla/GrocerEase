//
//  APIClient.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation


struct APIClient{
    
    // MARK: - Properties
    
    private static let decoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private static let successRange = 200..<300
    
    
    // MARK: - SendRequest
    
    static func sendRequest<T:Decodable>(endpoint: GrocerTargetType) async throws -> T{
        let (data,response) = try await URLSession.shared.data(for: endpoint.asURLRequest())
        let validData = try validate(data: data, response: response)
        return try decoder.decode(T.self, from: validData)
    }
    
    // MARK: - Validate
    
    static func validate(data: Data, response: URLResponse) throws -> Data {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NSError(domain: String(data: data, encoding: .utf8) ?? "Network Error", code: 0)
        }
        
        if successRange.contains(code) {
            return data
        } else {
            switch code {
            case 401:
                throw NSError(domain: "Unauthorized", code: code)
            case 404:
                throw NSError(domain: "Not Found", code: code)
            default:
                throw NSError(domain: "Irregular Error", code: code)
            }
        }
    }
    
}

