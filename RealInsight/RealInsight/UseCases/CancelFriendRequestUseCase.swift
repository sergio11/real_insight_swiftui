//
//  CancelFriendRequestUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/4/24.
//

import Foundation

enum CancelFriendsRequestError: Error {
    case cancelFailed
}

struct CancelFriendsRequestParams {
    let toUserId: String
}

/// An entity responsible for canceling friend requests.
struct CancelFriendsRequestUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of canceling a friend request asynchronously.
        /// - Parameter params: The parameters needed for canceling a friend request.
        /// - Throws: An error if the cancellation process fails.
    func execute(params: CancelFriendsRequestParams) async throws {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw CancelFriendsRequestError.cancelFailed
        }
        do {
            return try await userRepository.cancelFriendRequest(from: userId, to: params.toUserId)
        } catch {
            throw CancelFriendsRequestError.cancelFailed
        }
    }
}

