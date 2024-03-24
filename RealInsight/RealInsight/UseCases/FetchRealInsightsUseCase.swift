//
//  FetchRealInsightsUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation


struct FetchRealInsightsUseCase {
    let repository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
    func execute(date: String) async throws -> (allRealInsights: [RealInsight], ownRealInsight: RealInsight?) {
        var result: (allRealInsights: [RealInsight], ownRealInsight: RealInsight?) = ([], nil)
        if let userId = try await authRepository.getCurrentUserId() {
            let allRealInsights = try await repository.fetchAllRealInsights(date: date)
            let ownRealInsight = try await repository.fetchOwnRealInsight(date: date, userId: userId)
            result = (allRealInsights, ownRealInsight)
        }
        return result
    }
}
