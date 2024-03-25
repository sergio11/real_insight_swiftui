//
//  GetCurrentUserUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 25/3/24.
//

import Foundation

enum GetCurrentUserError: Error {
    case userNotFound
}

struct GetCurrentUserUseCase {
    
    let authRepository: AuthenticationRepository
    let userRepository: UserProfileRepository
    
    func execute() async throws -> User {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw GetCurrentUserError.userNotFound
        }
        do {
            return try await userRepository.getUser(userId: userId)
        } catch {
            throw GetCurrentUserError.userNotFound
        }
    }
}
