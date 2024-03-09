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
    func saveUserData(data: SaveUserDTO) async throws -> UserDTO
    func getUserById(userId: String) async throws -> UserDTO
}
