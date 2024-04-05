//
//  SaveUserDataUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import UIKit

enum UpdateUserError: Error {
    case updateFailed
}

struct UpdateUserParams {
    let fullname: String
    let username: String?
    let location: String?
    let bio: String?
    let birthdate: String?
    let selectedImage: Data?
}

/// An entity responsible for updating user information.
struct UpdateUserUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the user information update asynchronously.
        /// - Parameters:
        ///   - params: Parameters containing the updated user information.
        /// - Returns: The updated user object.
        /// - Throws: An error if the update fails or if the current user session is invalid.
    func execute(params: UpdateUserParams) async throws -> User {
        if let userId = try await authRepository.getCurrentUserId() {
            return try await userRepository.updateUser(userId: userId, fullname: params.fullname, username: params.username, location: params.location, bio: params.bio, birthdate: params.birthdate, selectedImage: params.selectedImage)
        } else {
            throw UpdateUserError.updateFailed
        }
    }
}
