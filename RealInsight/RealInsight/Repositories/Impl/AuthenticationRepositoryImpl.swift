//
//  FirestoreAuthenticationRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

internal class AuthenticationRepositoryImpl: AuthenticationRepository {
    let authenticationDataSource: AuthenticationDataSource

    init(authenticationDataSource: AuthenticationDataSource) {
        self.authenticationDataSource = authenticationDataSource
    }

    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            return try await authenticationDataSource.signInWithPhone(phoneNumber: phoneNumber)
        } catch {
            throw AuthenticationRepositoryError.signInFailed
        }
    }

    func verifyOTP(verificationCode: String, otpCode: String) async throws -> User {
        do {
            return try await authenticationDataSource.verifyOTP(verificationCode: verificationCode, otpCode: otpCode)
        } catch {
            throw AuthenticationRepositoryError.verificationFailed
        }
    }

    func signOut() async throws {
        do {
            try await authenticationDataSource.signOut()
        } catch {
            throw AuthenticationRepositoryError.signOutFailed
        }
    }

    func getCurrentUser() async throws -> User? {
        do {
            return try await authenticationDataSource.getCurrentUser()
        } catch {
            throw AuthenticationRepositoryError.currentUserFetchFailed
        }
    }
}
