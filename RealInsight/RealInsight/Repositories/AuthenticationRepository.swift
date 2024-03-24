//
//  AuthenticationRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

enum AuthenticationRepositoryError: Error {
    case signInFailed
    case verificationFailed
    case signOutFailed
    case currentUserFetchFailed
}


protocol AuthenticationRepository {
    func signInWithPhone(phoneNumber: String) async throws -> String
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String
    func signOut() async throws
    func getCurrentUserId() async throws -> String?
}
