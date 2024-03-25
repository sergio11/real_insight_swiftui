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
    let repository: AuthenticationRepository
    
    func verifySession() async throws -> String {
        guard let userId = try await repository.getCurrentUserId() else {
            throw VerifySessionError.invalidSession
        }
        return userId
    }
}
