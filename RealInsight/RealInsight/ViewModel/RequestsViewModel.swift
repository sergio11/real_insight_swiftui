//
//  RequestsViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation
import SwiftUI
import Factory

class RequestsViewModel: BaseUserViewModel {
    
    @Published var requests: [User] = []
    
    @Injected(\.fetchFollowersRequestsUseCase) private var fetchFollowersRequestsUseCase: FetchFollowersRequestsUseCase
    
    func loadRequests() {
        executeAsyncTask({
            return try await self.fetchFollowersRequestsUseCase.execute()
        }, completion: { [weak self] result in
            if case .success(let requests) = result {
                self?.requests = requests
            }
        })
    }
}
