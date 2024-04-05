//
//  UserDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

/// Enum representing errors that can occur in the `UserDataSource`.
enum UserDataSourceError: Error {
    /// Error indicating that saving user data failed.
    case saveFailed
    /// Error indicating that the user was not found.
    case userNotFound
    /// Error indicating that the friend has already been added.
    case friendAlreadyAdded(message: String)
    /// Error indicating that the provided user ID is invalid.
    case invalidUserId(message: String)
    /// Error indicating that the friend request already exists.
    case requestAlreadyExists(message: String)
}

/// Protocol defining operations for managing user data.
protocol UserDataSource {
    /// Updates user data asynchronously.
    /// - Parameter data: The data of the user to be updated.
    /// - Returns: A `UserDTO` object representing the updated user.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO
    
    /// Creates a new user asynchronously.
    /// - Parameter data: The data of the user to be created.
    /// - Returns: A `UserDTO` object representing the created user.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func createUser(data: CreateUserDTO) async throws -> UserDTO
    
    /// Creates a friend request from one user to another asynchronously.
    /// - Parameters:
    ///   - fromUserId: The ID of the user sending the friend request.
    ///   - toUserId: The ID of the user receiving the friend request.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func createFriendRequest(from fromUserId: String, to toUserId: String) async throws
    
    /// Cancels a friend request from one user to another asynchronously.
    /// - Parameters:
    ///   - fromUserId: The ID of the user canceling the friend request.
    ///   - toUserId: The ID of the user whose friend request is being canceled.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func cancelFriendRequest(from fromUserId: String, to toUserId: String) async throws
    
    /// Confirms a friend request from one user to another asynchronously.
    /// - Parameters:
    ///   - fromUserId: The ID of the user confirming the friend request.
    ///   - toUserId: The ID of the user whose friend request is being confirmed.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func confirmFriendRequest(from fromUserId: String, to toUserId: String) async throws
    
    /// Retrieves user data from Firestore based on the provided user ID asynchronously.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `UserDTO` object containing the user data.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getUserById(userId: String) async throws -> UserDTO
    
    /// Retrieves user data for a list of user IDs asynchronously.
    /// - Parameter userIds: An array of user IDs to retrieve user data for.
    /// - Returns: An array of `UserDTO` objects containing the user data.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getUserByIdList(userIds: [String]) async throws -> [UserDTO]
    
    /// Retrieves suggestions for users based on the authenticated user ID asynchronously.
    /// - Parameter authUserId: The ID of the authenticated user.
    /// - Returns: An array of `UserDTO` objects representing user suggestions.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getSuggestions(authUserId: String) async throws -> [UserDTO]
    
    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A Boolean value indicating whether the username is available.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func checkUsernameAvailability(username: String) async throws -> Bool
}
