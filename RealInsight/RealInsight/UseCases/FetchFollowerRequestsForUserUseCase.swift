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

struct FetchFollowersRequestsUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
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
