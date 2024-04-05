//
//  FetchRealInsightsUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

enum FetchRealInsightsError: Error {
    case fetchFailed
}

/// An entity responsible for fetching real insights.
struct FetchRealInsightsUseCase {
    let repository: RealInsightsRepository
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the fetch operation for real insights asynchronously.
        /// - Parameter date: The date for which to fetch real insights.
        /// - Returns: A tuple containing all real insights fetched and the user's own real insight, if available.
        /// - Throws: An error if the fetch operation fails.
    func execute(date: Date) async throws -> (allRealInsights: [RealInsight], ownRealInsight: RealInsight?) {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw FetchRealInsightsError.fetchFailed
        }
        do {
            let allRealInsights = try await repository.fetchAllRealInsights(date: date, userId: userId)
            let ownRealInsight = allRealInsights.first(where: { $0.user.id == userId })
            let filteredRealInsights = allRealInsights.filter { $0.user.id != userId }
            return (filteredRealInsights, ownRealInsight)
        } catch {
            throw FetchRealInsightsError.fetchFailed
        }
    }
}
