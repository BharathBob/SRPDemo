//
//  UserScreenView.swift
//  SRPDemo
//
//  Created by Sowmya Bharath on 25/12/25.
//

import SwiftUI

struct UserScreenView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing:16) {
            Text(viewModel.message)
            if let user = viewModel.user {
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
            }
        }
        .task{
            await self.viewModel.loadData()
        }
    }
}

#Preview {
    UserScreenView()
}
