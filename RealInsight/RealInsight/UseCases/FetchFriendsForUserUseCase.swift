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

struct FetchFriendsUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
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
