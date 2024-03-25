//
//  FirestoreUserDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A data source responsible for managing user data in Firestore.
internal class FirestoreUserDataSourceImpl: UserDataSource {
    
    /// Saves user data to Firestore.
        /// - Parameters:
        ///   - data: The data of the user to be saved.
        /// - Returns: A `UserDTO` object representing the saved user.
        /// - Throws: An error if the operation fails.
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
            .firestore()
            .collection("users")
            .document(data.userId)
        do {
            // Save user data to Firestore
            try await documentReference.setData(data.asDictionary(), merge: true)
            // Return the saved user data by fetching it from Firestore
            return try await getUserById(userId: data.userId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func createUser(data: CreateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
                .firestore()
                .collection("users")
                .document(data.userId)
        do {
            // Save user data to Firestore
            try await documentReference.setData(data.asDictionary())
            // Return the saved user data by fetching it from Firestore
            return try await getUserById(userId: data.userId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Retrieves user data from Firestore based on the provided user ID.
        /// - Parameter userId: The ID of the user to retrieve.
        /// - Returns: A `UserDTO` object containing the user data.
        /// - Throws: An error if the user data is not found or if the operation fails.
    func getUserById(userId: String) async throws -> UserDTO {
        let documentSnapshot = try await Firestore
            .firestore()
            .collection("users")
            .document(userId)
            .getDocument()
        // Attempt to decode the document data into a UserDTO object
        guard let userData = try? documentSnapshot.data(as: UserDTO.self) else {
            throw UserDataSourceError.userNotFound
        }
        return userData
    }
}
