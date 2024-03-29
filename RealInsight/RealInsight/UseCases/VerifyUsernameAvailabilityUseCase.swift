//
//  VerifyUsernameAvailabilityUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/3/24.
//

import Foundation

struct VerifyUsernameParams {
    let username: String
}

struct VerifyUsernameAvailabilityUseCase {
    let userProfileRepository: UserProfileRepository
    
    func execute(params: VerifyUsernameParams) async throws -> Bool {
        return try await userProfileRepository.checkUsernameAvailability(username: params.username)
    }
}
