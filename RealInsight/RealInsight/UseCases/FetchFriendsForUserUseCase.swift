//
//  FetchFriendsForUserUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation

enum FetchFriendsError: Error {
    case fetchFailed
}

/// An entity responsible for fetching friends of the current user.
struct FetchFriendsUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of fetching friends of the current user asynchronously.
        /// - Returns: An array of `User` objects representing the fetched friends.
        /// - Throws: An error if the fetching operation fails.
    func execute() async throws -> [User] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw FetchFriendsError.fetchFailed
        }
        do {
            return try await userRepository.fetchFriendsForUser(authUserId: userId)
        } catch {
            throw FetchFriendsError.fetchFailed
        }
    }
}
