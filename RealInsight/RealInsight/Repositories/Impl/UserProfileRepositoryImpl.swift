//
//  FirestoreUserProfileRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

/// Class responsible for managing user profile-related operations.
internal class UserProfileRepositoryImpl: UserProfileRepository {
    
    private let userDataSource: UserDataSource
    private let storageFilesDataSource: StorageFilesDataSource
    private let userMapper: UserMapper
    
    /// Initializes an instance of `UserProfileRepositoryImpl`.
        /// - Parameters:
        ///   - userDataSource: The data source for user-related operations.
        ///   - storageFilesDataSource: The data source for file storage operations.
        ///   - userMapper: The mapper used to map user-related data objects.
    init(userDataSource: UserDataSource, storageFilesDataSource: StorageFilesDataSource, userMapper: UserMapper) {
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.userMapper = userMapper
    }
    
    /// Updates the user profile asynchronously.
        /// - Parameters:
        ///   - userId: The ID of the user to be updated.
        ///   - fullname: The new full name of the user.
        ///   - username: The new username of the user.
        ///   - location: The new location of the user.
        ///   - bio: The new bio of the user.
        ///   - birthdate: The new birthdate of the user.
        ///   - selectedImage: The new profile image of the user as `Data`.
        /// - Returns: The updated `User` object.
        /// - Throws: An error if the operation fails.
    func updateUser(userId: String, fullname: String, username: String?, location: String?, bio: String?, birthdate: String?, selectedImage: Data?) async throws -> User {
        do {
            var profileImageUrl: String? = nil
            if let selectedImage = selectedImage {
                profileImageUrl = try await storageFilesDataSource.uploadImage(imageData: selectedImage, type: .profile)
            }
            let userData = try await userDataSource.updateUser(data: UpdateUserDTO(userId: userId, fullname: fullname, username: username, location: location, bio: bio, birthdate: birthdate, profileImageUrl: profileImageUrl))
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Creates a new user account asynchronously.
        /// - Parameters:
        ///   - userId: The ID of the new user account.
        ///   - username: The username of the new user account.
        ///   - birthdate: The birthdate of the new user account.
        ///   - phoneNumber: The phone number of the new user account.
        /// - Returns: The created `User` object.
        /// - Throws: An error if the operation fails.
    func createUser(userId: String, username: String, birthdate: String, phoneNumber: String) async throws -> User {
        do {
            let userData = try await userDataSource.createUser(data: CreateUserDTO(userId: userId, username: username, birthdate: birthdate, phoneNumber: phoneNumber))
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Fetches user data asynchronously based on the provided user ID.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `User` object containing the user data.
    /// - Throws: An error if the user data cannot be retrieved.
    func getUser(userId: String) async throws -> User {
        do {
            let userData = try await userDataSource.getUserById(userId: userId)
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Fetches user suggestions asynchronously for the provided authenticated user ID.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch suggestions.
    /// - Returns: An array of `User` objects representing the fetched user suggestions.
    /// - Throws: An error if the user suggestions cannot be retrieved.
    func getSuggestions(authUserId: String) async throws -> [User] {
        do {
            let userData = try await userDataSource.getSuggestions(authUserId: authUserId)
            let users = userData.map { userMapper.map($0) }
            return users
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Fetches friends of the user asynchronously for the provided authenticated user ID.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch friends.
    /// - Returns: An array of `User` objects representing the fetched friends of the user.
    /// - Throws: An error if the user's friends cannot be retrieved.
    func fetchFriendsForUser(authUserId: String) async throws -> [User] {
        do {
            let userData = try await userDataSource.getUserById(userId: authUserId)
            guard !userData.friends.isEmpty else { return [] }
            let friendsData = try await userDataSource.getUserByIdList(userIds: userData.friends)
            return friendsData.map { userMapper.map($0) }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Fetches follower requests for the user asynchronously for the provided authenticated user ID.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch follower requests.
    /// - Returns: An array of `User` objects representing the users who have sent follower requests to the authenticated user.
    /// - Throws: An error if the follower requests cannot be retrieved.
    func fetchFollowerRequestsForUser(authUserId: String) async throws -> [User] {
        do {
            let userData = try await userDataSource.getUserById(userId: authUserId)
            // Check if the user has any follower requests
            guard !userData.followerRequests.isEmpty else { return [] }
            // Fetch details of users who sent follower requests
            let requestsData = try await userDataSource.getUserByIdList(userIds: userData.followerRequests)
            // Map the user data to User objects
            return requestsData.map { userMapper.map($0) }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A boolean value indicating whether the username is available or not.
    /// - Throws: An error if the availability check fails.
    func checkUsernameAvailability(username: String) async throws -> Bool {
        do {
            return try await userDataSource.checkUsernameAvailability(username: username)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Creates a friend request asynchronously from one user to another.
    /// - Parameters:
    ///   - from: The ID of the user sending the friend request.
    ///   - to: The ID of the user receiving the friend request.
    /// - Throws: An error if the friend request creation fails.
    func createFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        do {
            return try await userDataSource.createFriendRequest(from: fromUserId, to: toUserId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Cancels a friend request asynchronously from one user to another.
    /// - Parameters:
    ///   - from: The ID of the user who initiated the friend request.
    ///   - to: The ID of the user who received the friend request.
    /// - Throws: An error if the friend request cancellation fails.
    func cancelFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        do {
            return try await userDataSource.cancelFriendRequest(from: fromUserId, to: toUserId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Confirms a friend request asynchronously from one user to another.
    /// - Parameters:
    ///   - from: The ID of the user who sent the friend request.
    ///   - to: The ID of the user who accepted the friend request.
    /// - Throws: An error if the friend request confirmation fails.
    func confirmFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        do {
            return try await userDataSource.confirmFriendRequest(from: fromUserId, to: toUserId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
