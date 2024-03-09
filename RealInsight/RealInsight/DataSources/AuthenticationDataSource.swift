//
//  AuthenticationDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

protocol AuthenticationDataSource {
    func signInWithPhone(phoneNumber: String) async throws -> String
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> User
    func signOut() async throws
    func getCurrentUser() async throws -> User?
}
