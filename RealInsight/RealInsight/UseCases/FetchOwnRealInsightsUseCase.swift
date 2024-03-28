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

struct FetchOwnRealInsightsUseCase {
    let realInsightsRepository: RealInsightsRepository
    let authRepository: AuthenticationRepository
    
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
