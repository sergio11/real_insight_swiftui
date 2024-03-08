//
//  AuthenticationRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

protocol AuthenticationRepository {
    func signInWithPhone(phoneNumber: String) async throws -> String
    func verifyOTP(verificationCode: String, otpText: String) async throws -> User
    func signOut() async throws
    func getCurrentUser() async throws -> User?
}
