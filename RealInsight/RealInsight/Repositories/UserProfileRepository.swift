//
//  UserProfileRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

/// A repository for user profile-related operations.
protocol UserProfileRepository {
    /// Updates the user's profile information asynchronously.
    /// - Parameters:
    ///   - userId: The ID of the user whose profile is being updated.
    ///   - fullname: The full name of the user.
    ///   - username: The username of the user, if provided.
    ///   - location: The location of the user, if provided.
    ///   - bio: The bio of the user, if provided.
    ///   - birthdate: The birthdate of the user, if provided.
    ///   - selectedImage: The selected profile image data, if provided.
    /// - Returns: A `User` object representing the updated user profile.
    /// - Throws: An error if the profile update fails.
    func updateUser(userId: String, fullname: String, username: String?, location: String?, bio: String?, birthdate: String?, selectedImage: Data?) async throws -> User

    /// Creates a new user asynchronously.
    /// - Parameters:
    ///   - userId: The ID of the new user.
    ///   - username: The username of the new user.
    ///   - birthdate: The birthdate of the new user.
    ///   - phoneNumber: The phone number of the new user.
    /// - Returns: A `User` object representing the newly created user.
    /// - Throws: An error if user creation fails.
    func createUser(userId: String, username: String, birthdate: String, phoneNumber: String) async throws -> User

    /// Retrieves user information asynchronously.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `User` object representing the retrieved user.
    /// - Throws: An error if user retrieval fails.
    func getUser(userId: String) async throws -> User

    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A boolean value indicating whether the username is available or not.
    /// - Throws: An error if the availability check fails.
    func checkUsernameAvailability(username: String) async throws -> Bool

    /// Fetches friends for the specified user asynchronously.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch friends.
    /// - Returns: An array of `User` objects representing the user's friends.
    /// - Throws: An error if friend retrieval fails.
    func fetchFriendsForUser(authUserId: String) async throws -> [User]

    /// Fetches follower requests for the specified user asynchronously.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch follower requests.
    /// - Returns: An array of `User` objects representing users who have sent follower requests to the authenticated user.
    /// - Throws: An error if follower request retrieval fails.
    func fetchFollowerRequestsForUser(authUserId: String) async throws -> [User]

    /// Fetches user suggestions for the specified authenticated user asynchronously.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch suggestions.
    /// - Returns: An array of `User` objects representing user suggestions.
    /// - Throws: An error if suggestion retrieval fails.
    func getSuggestions(authUserId: String) async throws -> [User]

    /// Creates a friend request asynchronously from one user to another.
    /// - Parameters:
    ///   - from: The ID of the user sending the friend request.
    ///   - to: The ID of the user receiving the friend request.
    /// - Throws: An error if friend request creation fails.
    func createFriendRequest(from fromUserId: String, to toUserId: String) async throws

    /// Cancels a friend request asynchronously from one user to another.
    /// - Parameters:
    ///   - from: The ID of the user who initiated the friend request.
    ///   - to: The ID of the user who received the friend request.
    /// - Throws: An error if friend request cancellation fails.
    func cancelFriendRequest(from fromUserId: String, to toUserId: String) async throws

    /// Confirms a friend request asynchronously from one user to another.
    /// - Parameters:
    ///   - from: The ID of the user who sent the friend request.
    ///   - to: The ID of the user who accepted the friend request.
    /// - Throws: An error if friend request confirmation fails.
    func confirmFriendRequest(from fromUserId: String, to toUserId: String) async throws
}
