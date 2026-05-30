//
//  NetworkClient.swift
//  MiniMart
//
//  Created by Venkatesh on 5/14/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(Int)
}

public final class NetworkClient {
    private let session: URLSession
    private let baseURL = "https://api.escuelajs.co/api/v1"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Codable>(endpoint: Endpoint) async throws -> T {
        // Build URL
        guard let url = URL(string: baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        // Build request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Execute
        let (data, response) = try await session.data(for: urlRequest)
        
        // Validate response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        // Decode
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
}
