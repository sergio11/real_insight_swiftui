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
    
    func checkUsernameAvailability(username: String) async throws -> Bool {
        do {
            return try await userDataSource.checkUsernameAvailability(username: username)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
