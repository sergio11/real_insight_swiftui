//
//  AuthenticationRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

/// Enum representing errors that can occur in the `AuthenticationRepository`.
enum AuthenticationRepositoryError: Error {
    /// Error indicating that sign-in failed.
    case signInFailed
    /// Error indicating that verification failed.
    case verificationFailed
    /// Error indicating that sign-out failed.
    case signOutFailed
    /// Error indicating that fetching the current user ID failed.
    case currentUserFetchFailed
}

/// Protocol defining authentication operations.
protocol AuthenticationRepository {
    /// Signs in with the provided phone number asynchronously.
    /// - Parameter phoneNumber: The phone number to be verified.
    /// - Returns: A verification ID as a string.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to sign-in failure.
    func signInWithPhone(phoneNumber: String) async throws -> String
    
    /// Verifies the OTP code asynchronously.
    /// - Parameters:
    ///   - verificationCode: The verification code received through SMS.
    ///   - otpCode: The OTP code entered by the user.
    /// - Returns: The user ID as a string upon successful verification.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to verification failure.
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String
    
    /// Signs out the current user asynchronously.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to sign-out failure.
    func signOut() async throws
    
    /// Fetches the current user ID asynchronously.
    /// - Returns: The current user ID as a string, or `nil` if no user is signed in.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to user ID fetching failure.
    func getCurrentUserId() async throws -> String?
}
