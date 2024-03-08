//
//  FetchRealInsightsUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation


struct FetchRealInsightsUseCase {
    let repository: RealInsightsRepository
    
    func execute(date: String, userId: String?) async throws -> (allRealInsights: [RealInsight], ownRealInsight: RealInsight?) {
        let allRealInsights = try await repository.fetchAllRealInsights(date: date)
        let ownRealInsight = try await userId != nil ? repository.fetchOwnRealInsight(date: date, userId: userId!) : nil
        return (allRealInsights, ownRealInsight)
    }
}
