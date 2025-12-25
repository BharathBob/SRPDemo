//
//  UserViewModel.swift
//  SRPDemo
//
//  Created by Sowmya Bharath on 25/12/25.
//

import Foundation
import Combine

class UserViewModel:ObservableObject {
    @Published var user: User?
    @Published var message = "Loading..."
    private let userService: UserRepository
    
    init(userService: UserRepository = UserRepository()) {
        self.userService = userService
    }
    
    func loadData() async {
         let result = await userService.fetchUser()
        switch result {
        case .success(let user):
             self.user = user
            message = "Loaded successfully"
        case .failure(let error):
            message = "Error loading data \(error.localizedDescription)"
        }
    }
}
