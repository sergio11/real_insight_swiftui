//
//  VerifySessionUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

enum VerifySessionError: Error {
    case invalidSession
}

struct VerifySessionUseCase {
    let authRepository: AuthenticationRepository
    let userProfileRepository: UserProfileRepository
    
    func execute() async throws -> Bool {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw VerifySessionError.invalidSession
        }
        var userData: User? = nil
        do {
            userData = try await userProfileRepository.getUser(userId: userId)
        } catch {
            try await authRepository.signOut()
            throw VerifySessionError.invalidSession
        }
        return userData != nil
    }
}
