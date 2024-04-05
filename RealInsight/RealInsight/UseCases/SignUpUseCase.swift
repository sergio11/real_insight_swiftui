//
//  SignUpUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 24/3/24.
//

import Foundation

struct SignUpParams {
    let name: String
    let birthdate: String
    let phoneNumber: String
    let verificationCode: String
    let otpText: String
}

/// An entity responsible for signing up a new user.
struct SignUpUseCase {
    let authRepository: AuthenticationRepository
    let userRepository: UserProfileRepository
    
    /// Executes the process of signing up a new user asynchronously.
        /// - Parameter params: Parameters required for signing up, including name, birthdate, phone number, verification code, and OTP text.
        /// - Returns: The newly signed-up user.
        /// - Throws: An error if the sign-up operation fails.
    func execute(params: SignUpParams) async throws -> User {
        let userId = try await authRepository.verifyOTP(verificationCode: params.verificationCode, otpCode: params.otpText)
        return try await userRepository.createUser(userId: userId, username: params.name, birthdate: params.birthdate, phoneNumber: params.phoneNumber)
    }
}
