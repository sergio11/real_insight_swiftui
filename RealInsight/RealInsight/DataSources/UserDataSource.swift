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
    func getUserById(userId: String) async throws -> UserDTO
    func checkUsernameAvailability(username: String) async throws -> Bool
}
