//
//  FirestoreAuthenticationRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

internal class AuthenticationRepositoryImpl: AuthenticationRepository {
    private let authenticationDataSource: AuthenticationDataSource

    init(authenticationDataSource: AuthenticationDataSource) {
        self.authenticationDataSource = authenticationDataSource
    }

    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            return try await authenticationDataSource.signInWithPhone(phoneNumber: phoneNumber)
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.signInFailed
        }
    }

    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String {
        do {
            return try await authenticationDataSource.verifyOTP(verificationCode: verificationCode, otpCode: otpCode)
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.verificationFailed
        }
    }

    func signOut() async throws {
        do {
            try await authenticationDataSource.signOut()
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.signOutFailed
        }
    }

    func getCurrentUserId() async throws -> String? {
        do {
            return try await authenticationDataSource.getCurrentUserId()
        } catch {
            print(error.localizedDescription)
            throw AuthenticationRepositoryError.currentUserFetchFailed
        }
    }
}
