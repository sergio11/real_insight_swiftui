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

struct FetchRealInsightsUseCase {
    let repository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
    func execute(date: Date) async throws -> (allRealInsights: [RealInsight], ownRealInsight: RealInsight?) {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw FetchRealInsightsError.fetchFailed
        }
        do {
            let allRealInsights = try await repository.fetchAllRealInsights(date: date)
            let ownRealInsight = allRealInsights.first(where: { $0.user.id == userId })
            let filteredRealInsights = allRealInsights.filter { $0.user.id != userId }
            return (filteredRealInsights, ownRealInsight)
        } catch {
            throw FetchRealInsightsError.fetchFailed
        }
    }
}
