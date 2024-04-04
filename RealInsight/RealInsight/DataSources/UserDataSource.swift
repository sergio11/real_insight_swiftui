//
//  UserDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

enum UserDataSourceError: Error {
    case saveFailed
    case userNotFound
}

protocol UserDataSource {
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO
    func createUser(data: CreateUserDTO) async throws -> UserDTO
    func createFriendRequest(from fromUserId: String, to toUserId: String) async throws
    func cancelFriendRequest(from fromUserId: String, to toUserId: String) async throws
    func confirmFriendRequest(from fromUserId: String, to toUserId: String) async throws
    func getUserById(userId: String) async throws -> UserDTO
    func getUserByIdList(userIds: [String]) async throws -> [UserDTO]
    func getSuggestions(authUserId: String) async throws -> [UserDTO]
    func checkUsernameAvailability(username: String) async throws -> Bool
}
