//
//  SaveUserDataUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import UIKit


struct UpdateUserParams {
    let fullname: String
    let username: String?
    let location: String?
    let bio: String?
    let selectedImage: Data?
}

struct UpdateUserUseCase {
    let userRepository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    func execute(params: UpdateUserParams) async throws -> User {
        if let userId = try await authRepository.getCurrentUserId() {
            return try await userRepository.updateUser(userId: userId, fullname: params.fullname, username: params.username, location: params.location, bio: params.bio, selectedImage: params.selectedImage)
        } else {
            throw NSError(domain: "SaveUserDataUseCase", code: 404, userInfo: [NSLocalizedDescriptionKey: "User session not found"])
        }
    }
}