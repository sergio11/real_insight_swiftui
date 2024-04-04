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

struct CreateFriendsRequestUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
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
    
