//
//  VerifyOtpUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

struct SignInParams {
    let verificationCode: String
    let otpText: String
}

struct SignInUseCase {
    let authRepository: AuthenticationRepository
    let userProfileRepository: UserProfileRepository
    
    func execute(params: SignInParams) async throws -> User {
        let userId = try await authRepository.verifyOTP(verificationCode: params.verificationCode, otpCode: params.otpText)
        return try await userProfileRepository.getUser(userId: userId)
    }
}
