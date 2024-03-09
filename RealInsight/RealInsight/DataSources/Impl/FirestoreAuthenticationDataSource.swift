//
//  FirestoreAuthenticationDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase

internal class FirestoreAuthenticationDataSource: AuthenticationDataSource {
    
    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            return result
        } catch {
            throw error
        }
    }
        
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> User {
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpCode)
            let result = try await Auth.auth().signIn(with: credential)
            let userDocument = Firestore.firestore().collection("users").document(result.user.uid)
            let snapshot = try await userDocument.getDocument()
            if var userData = snapshot.data() {
                let user = User(
                    fullname: userData["fullname"] as? String ?? "",
                    date: userData["date"] as? String ?? "",
                    phone: userData["phone"] as? String ?? ""
                )
                return user
            } else {
                throw NSError(domain: "FirestoreAuthenticationRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "User data not found"])
            }
        } catch {
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
        
    func getCurrentUser() async throws -> User? {
        guard let userSession = Auth.auth().currentUser else {
            return nil
        }
        let userDocument = Firestore.firestore().collection("users").document(userSession.uid)
        do {
            let snapshot = try await userDocument.getDocument()
            if let userData = snapshot.data() {
                let user = User(
                    fullname: userData["fullname"] as? String ?? "",
                    date: userData["date"] as? String ?? "",
                    phone: userData["phone"] as? String ?? ""
                )
                return user
            } else {
                throw NSError(domain: "FirestoreAuthenticationRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "User data not found"])
            }
        } catch {
            throw error
        }
    }
}
