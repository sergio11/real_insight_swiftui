//
//  AuthenticationDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

/// An enumeration representing possible authentication errors.
enum AuthenticationError: Error {
    /// Error indicating failure in phone number verification.
    case phoneVerificationFailed(message: String)
    /// Error indicating failure in signing in.
    case signInFailed(message: String)
    /// Error indicating failure in signing out.
    case signOutFailed(message: String)
}

/// A protocol defining authentication operations.
protocol AuthenticationDataSource {
    /// Signs in with the provided phone number asynchronously.
    /// - Parameter phoneNumber: The phone number to be verified.
    /// - Returns: A verification ID as a string.
    /// - Throws: An `AuthenticationError` in case of failure, including `phoneVerificationFailed` if phone verification fails.
    func signInWithPhone(phoneNumber: String) async throws -> String
    
    /// Verifies the OTP (One-Time Password) code received via SMS verification.
    /// - Parameters:
    ///   - verificationCode: The verification ID received during phone number verification.
    ///   - otpCode: The OTP code received via SMS.
    /// - Returns: The user ID associated with the user who successfully signed in.
    /// - Throws: An `AuthenticationError` in case of failure, including `signInFailed` if sign-in fails.
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String
    
    /// Signs out the current user.
    /// - Throws: An `AuthenticationError` in case of failure, including `signOutFailed` if sign-out fails.
    func signOut() async throws
    
    /// Retrieves the current user's ID.
    /// - Returns: The user ID if the user is logged in, otherwise `nil`.
    /// - Throws: An `AuthenticationError` in case of failure.
    func getCurrentUserId() async throws -> String?
}

