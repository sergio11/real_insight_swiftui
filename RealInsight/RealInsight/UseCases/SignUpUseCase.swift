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

struct SignUpUseCase {
    let authRepository: AuthenticationRepository
    let userRepository: UserProfileRepository
    
    func execute(params: SignUpParams) async throws -> User {
        let userId = try await authRepository.verifyOTP(verificationCode: params.verificationCode, otpCode: params.otpText)
        return try await userRepository.createUser(userId: userId, username: params.name, birthdate: params.birthdate, phoneNumber: params.phoneNumber)
    }
}
