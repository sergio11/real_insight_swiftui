//
//  FetchOwnRealInsightsUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/3/24.
//

import Foundation

enum FetchOwnRealInsightsError: Error {
    case fetchFailed
}

/// An entity responsible for fetching real insights owned by the current user.
struct FetchOwnRealInsightsUseCase {
    let realInsightsRepository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of fetching real insights owned by the current user asynchronously.
        /// - Parameters:
        ///   - lastDays: The number of days from which to fetch the real insights.
        /// - Returns: An array of real insights owned by the current user.
        /// - Throws: An error if the real insights fetching operation fails, including `fetchFailed` if the operation fails.
    func execute(lastDays: Int) async throws -> [RealInsight] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw FetchOwnRealInsightsError.fetchFailed
        }
        do {
            return try await realInsightsRepository.fetchOwnRealInsight(lastDays: lastDays, userId: userId)
        } catch {
            throw FetchOwnRealInsightsError.fetchFailed
        }
    }
}
