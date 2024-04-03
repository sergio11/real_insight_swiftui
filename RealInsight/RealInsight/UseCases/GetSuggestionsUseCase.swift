//
//  GetSuggestionsUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation

enum GetSuggestionsError: Error {
    case fetchFailed
}

struct GetSuggestionsUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    func execute() async throws -> [User] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw GetSuggestionsError.fetchFailed
        }
        do {
            return try await userRepository.getSuggestions(authUserId: userId)
        } catch {
            throw GetSuggestionsError.fetchFailed
        }
    }
}
