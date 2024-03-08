//
//  VerifySessionUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

struct VerifySessionUseCase {
    let repository: AuthenticationRepository
    
    func verifySession() async throws -> User? {
        return try await repository.getCurrentUser()
    }
}
