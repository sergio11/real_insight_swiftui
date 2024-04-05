//
//  ConfirmFriendRequestUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/4/24.
//

import Foundation

enum ConfirmFriendsRequestError: Error {
    case confirmFailed
}

struct ConfirmFriendsRequestParams {
    let toUserId: String
}

/// An entity responsible for confirming friend requests.
struct ConfirmFriendsRequestUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of confirming a friend request asynchronously.
        /// - Parameter params: The parameters needed for confirming a friend request.
        /// - Throws: An error if the confirmation process fails.
    func execute(params: ConfirmFriendsRequestParams) async throws {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw ConfirmFriendsRequestError.confirmFailed
        }
        do {
            return try await userRepository.confirmFriendRequest(from: userId, to: params.toUserId)
        } catch {
            throw ConfirmFriendsRequestError.confirmFailed
        }
    }
}
