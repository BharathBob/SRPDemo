//
//  UserRepository.swift
//  SRPDemo
//
//  Created by Sowmya Bharath on 25/12/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser() async -> Result<User, NetworkError>
}

struct UserRepository: UserRepositoryProtocol {
    private let client: HttpClientProtocol
    
    init(client: HttpClientProtocol = HttpClient()) {
        self.client = client
    }
    
    func fetchUser() async -> Result<User, NetworkError> {
        
        let path = "https://jsonplaceholder.typicode.com/users/1"
        let result = await self.client.execute(apiPath: path)
        
        switch result {
        case .success(let success):
            do{
                let user = try JSONDecoder().decode(User.self, from: success)
                return .success(user)
            }
            catch {
                return .failure(.decodingError)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
