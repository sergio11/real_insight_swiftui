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
    let repository: AuthenticationRepository
    
    func execute(params: SignInParams) async throws -> String {
        return try await repository.verifyOTP(verificationCode: params.verificationCode, otpCode: params.otpText)
    }
}
