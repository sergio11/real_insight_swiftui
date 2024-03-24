//
//  FirestoreAuthenticationDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase

/// A data source responsible for handling authentication operations using Firestore.
internal class FirestoreAuthenticationDataSource: AuthenticationDataSource {
    
    /// Signs in with the provided phone number asynchronously.
        /// - Parameter phoneNumber: The phone number to be verified.
        /// - Returns: A verification ID as a string.
        /// - Throws: An `AuthenticationError` in case of failure, including `phoneVerificationFailed` if phone verification fails.
    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            return result
        } catch {
            throw AuthenticationError.phoneVerificationFailed(message: "Phone verification failed: \(error.localizedDescription)")
        }
    }
        
    /// Verifies the one-time password (OTP) code asynchronously.
        /// - Parameters:
        ///   - verificationCode: The verification code received.
        ///   - otpCode: The one-time password code.
        /// - Returns: A `User` object upon successful verification.
        /// - Throws: An `AuthenticationError` in case of failure, including `signInFailed` if sign-in fails and `userDataNotFound` if user data is not found.
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> User {
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpCode)
            let result = try await Auth.auth().signIn(with: credential)
            let userDocument = Firestore.firestore().collection("users").document(result.user.uid)
            let snapshot = try await userDocument.getDocument()
            if let userData = snapshot.data() {
                return try buildUser(from: userData)
            } else {
                throw AuthenticationError.userDataNotFound(message: "User data not found")
            }
        } catch {
            throw AuthenticationError.signInFailed(message: "Sign-in failed: \(error.localizedDescription)")
        }
    }
    
    /// Signs out the current user asynchronously.
        /// - Throws: An `AuthenticationError` if sign-out fails.
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw AuthenticationError.signOutFailed(message: "Sign-out failed: \(error.localizedDescription)")
        }
    }
        
    /// Retrieves the current user asynchronously.
    /// - Returns: An optional `User` object representing the current user.
    /// - Throws: An `AuthenticationError` if user data is not found.
    func getCurrentUser() async throws -> User? {
        guard let userSession = Auth.auth().currentUser else {
            return nil
        }
        let userDocument = Firestore.firestore().collection("users").document(userSession.uid)
        do {
            let snapshot = try await userDocument.getDocument()
            if let userData = snapshot.data() {
                return try buildUser(from: userData)
            } else {
                throw AuthenticationError.userDataNotFound(message: "User data not found")
            }
        } catch {
            throw AuthenticationError.userDataNotFound(message: "User data not found: \(error.localizedDescription)")
        }
    }
    
    /// Builds a `User` object from the provided user data.
        /// - Parameter userData: The user data dictionary.
        /// - Returns: A `User` object.
    private func buildUser(from userData: [String: Any]) throws -> User {
        return User(
            id: userData["id"] as? String ?? "",
            fullname: userData["fullname"] as? String ?? "",
            birthdate: userData["date"] as? String ?? "",
            username: userData["username"] as? String ?? "",
            profileImageUrl: userData["profileImageUrl"] as? String ?? "",
            bio: userData["bio"] as? String ?? "",
            location: userData["location"] as? String ?? "",
            phone: userData["phone"] as? String ?? ""
        )
    }
}
