//
//  FirestoreAuthenticationDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A data source responsible for handling authentication operations using Firestore.
internal class FirebaseAuthenticationDataSourceImpl: AuthenticationDataSource {
    
    /// Signs in with the provided phone number asynchronously.
        /// - Parameter phoneNumber: The phone number to be verified.
        /// - Returns: A verification ID as a string.
        /// - Throws: An `AuthenticationError` in case of failure, including `phoneVerificationFailed` if phone verification fails.
    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            return result
        } catch {
            print(error.localizedDescription)
            throw AuthenticationError.phoneVerificationFailed(message: "Phone verification failed: \(error.localizedDescription)")
        }
    }
        
    /// Verifies the OTP (One-Time Password) code received through SMS verification.
        /// - Parameters:
        ///   - verificationCode: The verification ID received during phone number verification.
        ///   - otpCode: The OTP code received via SMS.
        /// - Returns: The user ID associated with the successfully signed-in user.
        /// - Throws: An `AuthenticationError` in case of failure, including `signInFailed` if sign-in fails.
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String {
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpCode)
            let result = try await Auth.auth().signIn(with: credential)
            return result.user.uid
        } catch {
            print(error.localizedDescription)
            throw AuthenticationError.signInFailed(message: "Sign-in failed: \(error.localizedDescription)")
        }
    }
    
    /// Signs out the current user.
        /// - Throws: An `AuthenticationError` in case of failure, including `signOutFailed` if sign-out fails.
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
            throw AuthenticationError.signOutFailed(message: "Sign-out failed: \(error.localizedDescription)")
        }
    }
        
    /// Retrieves the ID of the current user.
        /// - Returns: The user ID if the user is signed in, otherwise `nil`.
        /// - Throws: An `AuthenticationError` in case of failure.
    func getCurrentUserId() async throws -> String? {
        guard let userSession = Auth.auth().currentUser else {
            return nil
        }
        return userSession.uid
    }
}
