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

struct ConfirmFriendsRequestUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
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
