//
//  Networking.swift
//  SRPDemo
//
//  Created by Sowmya Bharath on 16/12/25.
//
import Foundation 

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

protocol HttpClientProtocol {
    func execute(apiPath: String) async -> Result<Data, NetworkError>
}

final class HttpClient: HttpClientProtocol {
    
    func execute(apiPath: String) async -> Result<Data, NetworkError> {
        guard let url = URL(string: apiPath) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let http = response as? HTTPURLResponse,
                !(200...299).contains(http.statusCode) {
                return .failure(.serverError("Status: \(http.statusCode)"))
            }
            return .success(data)
        }
        catch {
            return .failure(.serverError(error.localizedDescription))
        }
    }
}
