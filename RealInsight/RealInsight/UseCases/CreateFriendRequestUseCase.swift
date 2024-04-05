//
//  CreateFriendRequestUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/4/24.
//

import Foundation

enum CreateFriendsRequestError: Error {
    case saveFailed
}

struct CreateFriendsRequestParams {
    let toUserId: String
}

/// An entity responsible for creating friend requests.
struct CreateFriendsRequestUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of creating a friend request asynchronously.
        /// - Parameter params: The parameters needed for creating a friend request.
        /// - Throws: An error if the creation process fails.
    func execute(params: CreateFriendsRequestParams) async throws {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw CreateFriendsRequestError.saveFailed
        }
        do {
            return try await userRepository.createFriendRequest(from: userId, to: params.toUserId)
        } catch {
            throw CreateFriendsRequestError.saveFailed
        }
    }
}
    
