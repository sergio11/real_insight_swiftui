//
//  PostRealInsightUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 24/3/24.
//

import Foundation

struct PostRealInsightUseCase {
    let repository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
    func execute(backImageData: Data, frontImageData: Data) async throws -> RealInsight? {
        var result: RealInsight? = nil
        if let currentUser = try await authRepository.getCurrentUser() {
            result = try await repository.postRealInsight(userId: currentUser.id, backImageData: backImageData, frontImageData: frontImageData)
        }
        return result
    }
}

