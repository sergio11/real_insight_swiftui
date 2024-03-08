//
//  VerifyOtpUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

struct VerifyOtpUseCase {
    let repository: AuthenticationRepository
    
    func execute(verificationCode: String, otpText: String) async throws -> User {
        return try await repository.verifyOTP(verificationCode: verificationCode, otpText: otpText)
    }
}
