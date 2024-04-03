//
//  FriendsViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation
import SwiftUI
import Factory

class FriendsViewModel: BaseUserViewModel {
    
    @Published var friends: [User] = []
    
    @Injected(\.fetchFriendsUseCase) private var fetchFriendsUseCase: FetchFriendsUseCase
    
    func loadFriends() {
        executeAsyncTask({
            return try await self.fetchFriendsUseCase.execute()
        }, completion: { [weak self] result in
            if case .success(let friends) = result {
                self?.friends = friends
            }
        })
    }
}
