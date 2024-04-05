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

/// An entity responsible for posting real insights.
struct PostRealInsightUseCase {
    let realInsightsRepository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of posting real insights asynchronously.
        /// - Parameters:
        ///   - backImageData: Data representing the back image.
        ///   - frontImageData: Data representing the front image.
        /// - Returns: The posted real insight.
        /// - Throws: An error if the post operation fails or if the current user session is invalid.
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

