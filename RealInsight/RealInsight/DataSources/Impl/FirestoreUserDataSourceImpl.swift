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
    
    private let usersCollection = "users"
    
    /// Saves user data to Firestore.
        /// - Parameters:
        ///   - data: The data of the user to be saved.
        /// - Returns: A `UserDTO` object representing the saved user.
        /// - Throws: An error if the operation fails.
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
            .firestore()
            .collection(usersCollection)
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
    
    /// Creates a new user in Firestore with the provided user data.
    /// - Parameter data: The data of the user to be created.
    /// - Returns: A `UserDTO` object representing the created user.
    /// - Throws: An error if the operation fails.
    func createUser(data: CreateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
                .firestore()
                .collection(usersCollection)
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
            .collection(usersCollection)
            .document(userId)
            .getDocument()
        // Attempt to decode the document data into a UserDTO object
        guard let userData = try? documentSnapshot.data(as: UserDTO.self) else {
            throw UserDataSourceError.userNotFound
        }
        return userData
    }
    
    /// Retrieves user data for a list of user IDs asynchronously.
    /// - Parameter userIds: An array of user IDs to retrieve user data for.
    /// - Returns: An array of `UserDTO` objects containing the user data.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getUserByIdList(userIds: [String]) async throws -> [UserDTO] {
        let querySnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .whereField("userId", in: userIds)
            .getDocuments()
        var usersData: [UserDTO] = []
        for document in querySnapshot.documents {
            if let userData = try? document.data(as: UserDTO.self) {
                usersData.append(userData)
            }
        }
        return usersData
    }
    
    /// Retrieves suggestions for users based on the authenticated user ID asynchronously.
    /// - Parameter authUserId: The ID of the authenticated user.
    /// - Returns: An array of `UserDTO` objects representing user suggestions.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getSuggestions(authUserId: String) async throws -> [UserDTO] {
        let documentSnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .document(authUserId)
            .getDocument()
        guard let userData = try? documentSnapshot.data(as: UserDTO.self) else {
            throw UserDataSourceError.userNotFound
        }
        let allIds = [authUserId] + userData.friends + userData.followingRequests + userData.followerRequests
        let querySnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .whereField("userId", notIn: allIds)
            .getDocuments()
        var suggestions: [UserDTO] = []
        for document in querySnapshot.documents {
            if let userData = try? document.data(as: UserDTO.self) {
                suggestions.append(userData)
            }
        }
        return suggestions
    }
    
    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A Boolean value indicating whether the username is available.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func checkUsernameAvailability(username: String) async throws -> Bool {
        let querySnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .whereField("username", isEqualTo: username)
            .getDocuments()
        return querySnapshot.isEmpty
    }
    
    /// Creates a friend request from one user to another asynchronously.
    /// - Parameters:
    ///   - fromUserId: The ID of the user sending the friend request.
    ///   - toUserId: The ID of the user receiving the friend request.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func createFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        let db = Firestore.firestore()
        let fromUserReference = db.collection(usersCollection).document(fromUserId)
        let toUserReference = db.collection(usersCollection).document(toUserId)
        // Check if fromUserId is already in the friends list of toUserId
        let toUserSnapshot = try await toUserReference.getDocument()
        if let data = toUserSnapshot.data(), let friends = data["friends"] as? [String], friends.contains(fromUserId) {
            // fromUserId is already a friend of toUserId
            throw UserDataSourceError.friendAlreadyAdded(message: "This user is already your friend.")
        }
        // Check if toUserId is already in the friends list of fromUserId
        let fromUserSnapshot = try await fromUserReference.getDocument()
        if let data = fromUserSnapshot.data(), let friends = data["friends"] as? [String], friends.contains(toUserId) {
            // toUserId is already a friend of fromUserId
            throw UserDataSourceError.friendAlreadyAdded(message: "This user is already your friend.")
        }
        // If they are not already connected as friends, update the requests
        do {
            try await fromUserReference.updateData([
                "followingRequests": FieldValue.arrayUnion([toUserId])
            ])
            try await toUserReference.updateData([
                "followerRequests": FieldValue.arrayUnion([fromUserId])
            ])
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Cancels a friend request from one user to another asynchronously.
    /// - Parameters:
    ///   - fromUserId: The ID of the user canceling the friend request.
    ///   - toUserId: The ID of the user whose friend request is being canceled.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func cancelFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        let db = Firestore.firestore()
        let fromUserReference = db
            .collection(usersCollection)
            .document(fromUserId)
        let toUserReference = db
            .collection(usersCollection)
            .document(toUserId)
        do {
            try await fromUserReference.updateData([
                "followerRequests": FieldValue.arrayRemove([toUserId])
            ])
            try await toUserReference.updateData([
                "followingRequests": FieldValue.arrayRemove([fromUserId])
            ])
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Confirms a friend request from one user to another asynchronously.
    /// - Parameters:
    ///   - fromUserId: The ID of the user confirming the friend request.
    ///   - toUserId: The ID of the user whose friend request is being confirmed.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func confirmFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        let db = Firestore.firestore()
        let fromUserReference = db
            .collection(usersCollection)
            .document(fromUserId)
        let toUserReference = db
            .collection(usersCollection)
            .document(toUserId)
        do {
            try await fromUserReference.updateData([
                "followerRequests": FieldValue.arrayRemove([toUserId]),
                "friends": FieldValue.arrayUnion([toUserId])
            ])
            try await toUserReference.updateData([
                "followingRequests": FieldValue.arrayRemove([fromUserId]),
                "friends": FieldValue.arrayUnion([fromUserId])
            ])
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
