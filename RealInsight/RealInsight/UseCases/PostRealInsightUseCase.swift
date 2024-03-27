//
//  PostRealInsightUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 24/3/24.
//

import Foundation

enum PostRealInsightError: Error {
    case postFailed
}

struct PostRealInsightUseCase {
    let realInsightsRepository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
    func execute(backImageData: Data, frontImageData: Data) async throws -> RealInsight {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw PostRealInsightError.postFailed
        }
        do {
            let realInsight = try await realInsightsRepository.postRealInsight(userId: userId, backImageData: backImageData, frontImageData: frontImageData)
            return realInsight
        } catch {
            throw PostRealInsightError.postFailed
        }
    }
}

