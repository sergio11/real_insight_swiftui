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
    @Injected(\.confirmFriendsRequestUseCase) private var confirmFriendsRequestUseCase: ConfirmFriendsRequestUseCase
    @Injected(\.cancelFriendsRequestUseCase) private var cancelFriendsRequestUseCase: CancelFriendsRequestUseCase
    
    func loadRequests() {
        executeAsyncTask({
            return try await self.fetchFollowersRequestsUseCase.execute()
        }, completion: { [weak self] result in
            if case .success(let requests) = result {
                self?.requests = requests
            }
        })
    }
    
    func confirmFriendRequest(userId: String) {
        executeAsyncTask({
            return try await self.confirmFriendsRequestUseCase.execute(params: ConfirmFriendsRequestParams(toUserId: userId))
        }, completion: { [weak self] result in
            self?.removeUserById(userId: userId)
        })
    }
    
    func cancelFriendRequest(userId: String) {
        executeAsyncTask({
            return try await self.cancelFriendsRequestUseCase.execute(params: CancelFriendsRequestParams(toUserId: userId))
        }, completion: { [weak self] result in
            self?.removeUserById(userId: userId)
        })
    }
    
    private func removeUserById(userId: String) {
        if let userIdx = requests.firstIndex(where: { $0.id == userId}) {
            requests.remove(at: userIdx)
        }
    }
}
