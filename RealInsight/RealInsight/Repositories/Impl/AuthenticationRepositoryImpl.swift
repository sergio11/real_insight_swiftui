//
//  FirestoreAuthenticationRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

// Class responsible for authentication repository operations.
internal class AuthenticationRepositoryImpl: AuthenticationRepository {
    
    private let authenticationDataSource: AuthenticationDataSource

    /// Initializes an instance of `AuthenticationRepositoryImpl`.
    /// - Parameter authenticationDataSource: The data source for authentication operations.
    init(authenticationDataSource: AuthenticationDataSource) {
        self.authenticationDataSource = authenticationDataSource
    }

    /// Signs in with the provided phone number asynchronously.
    /// - Parameter phoneNumber: The phone number to be verified.
    /// - Returns: A verification ID as a string.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to sign-in failure.
    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            return try await authenticationDataSource.signInWithPhone(phoneNumber: phoneNumber)
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.signInFailed
        }
    }

    /// Verifies the OTP code asynchronously.
    /// - Parameters:
    ///   - verificationCode: The verification code received through SMS.
    ///   - otpCode: The OTP code entered by the user.
    /// - Returns: The user ID as a string upon successful verification.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to verification failure.
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String {
        do {
            return try await authenticationDataSource.verifyOTP(verificationCode: verificationCode, otpCode: otpCode)
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.verificationFailed
        }
    }

    /// Signs out the current user asynchronously.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to sign-out failure.
    func signOut() async throws {
        do {
            try await authenticationDataSource.signOut()
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.signOutFailed
        }
    }

    /// Fetches the current user ID asynchronously.
    /// - Returns: The current user ID as a string, or `nil` if no user is signed in.
    /// - Throws: An `AuthenticationRepositoryError` in case of failure, including specific errors related to user ID fetching failure.
    func getCurrentUserId() async throws -> String? {
        do {
            return try await authenticationDataSource.getCurrentUserId()
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.currentUserFetchFailed
        }
    }
}
