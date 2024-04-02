//
//  UserProfileRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

protocol UserProfileRepository {
    
    func updateUser(
        userId: String,
        fullname: String,
        username: String?,
        location: String?,
        bio: String?,
        birthdate: String?,
        selectedImage: Data?
    ) async throws -> User
    
    func createUser(
        userId: String,
        username: String,
        birthdate: String,
        phoneNumber: String
    ) async throws -> User
    
    func getUser(userId: String) async throws -> User
    
    func checkUsernameAvailability(username: String) async throws -> Bool
}
