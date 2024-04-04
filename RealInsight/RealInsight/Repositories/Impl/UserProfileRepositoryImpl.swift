//
//  FirestoreUserProfileRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

internal class UserProfileRepositoryImpl: UserProfileRepository {
    
    private let userDataSource: UserDataSource
    private let storageFilesDataSource: StorageFilesDataSource
    private let userMapper: UserMapper
    
    init(userDataSource: UserDataSource, storageFilesDataSource: StorageFilesDataSource, userMapper: UserMapper) {
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.userMapper = userMapper
    }
    
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
    
    func createUser(userId: String, username: String, birthdate: String, phoneNumber: String) async throws -> User {
        do {
            let userData = try await userDataSource.createUser(data: CreateUserDTO(userId: userId, username: username, birthdate: birthdate, phoneNumber: phoneNumber))
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func getUser(userId: String) async throws -> User {
        do {
            let userData = try await userDataSource.getUserById(userId: userId)
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
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
    
    func fetchFollowerRequestsForUser(authUserId: String) async throws -> [User] {
        do {
            let userData = try await userDataSource.getUserById(userId: authUserId)
            guard !userData.followerRequests.isEmpty else { return [] }
            let requestsData = try await userDataSource.getUserByIdList(userIds: userData.followerRequests)
            return requestsData.map { userMapper.map($0) }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func checkUsernameAvailability(username: String) async throws -> Bool {
        do {
            return try await userDataSource.checkUsernameAvailability(username: username)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func createFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        do {
            return try await userDataSource.createFriendRequest(from: fromUserId, to: toUserId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func cancelFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        do {
            return try await userDataSource.cancelFriendRequest(from: fromUserId, to: toUserId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func confirmFriendRequest(from fromUserId: String, to toUserId: String) async throws {
        do {
            return try await userDataSource.confirmFriendRequest(from: fromUserId, to: toUserId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
