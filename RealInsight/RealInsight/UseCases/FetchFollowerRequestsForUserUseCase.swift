//
//  FetchFollowerRequestsForUserUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation

enum FetchFollowersRequestsError: Error {
    case fetchFailed
}

/// An entity responsible for fetching follower requests for the current user.
struct FetchFollowersRequestsUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of fetching follower requests for the current user asynchronously.
        /// - Returns: An array of `User` objects representing the fetched follower requests.
        /// - Throws: An error if the fetching operation fails.
    func execute() async throws -> [User] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw FetchFollowersRequestsError.fetchFailed
        }
        do {
            return try await userRepository.fetchFollowerRequestsForUser(authUserId: userId)
        } catch {
            throw FetchFollowersRequestsError.fetchFailed
        }
    }
}
