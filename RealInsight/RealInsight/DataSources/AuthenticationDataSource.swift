//
//  AuthenticationDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

enum AuthenticationError: Error {
    case phoneVerificationFailed(message: String)
    case signInFailed(message: String)
    case signOutFailed(message: String)
}

protocol AuthenticationDataSource {
    func signInWithPhone(phoneNumber: String) async throws -> String
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String
    func signOut() async throws
    func getCurrentUserId() async throws -> String?
}
