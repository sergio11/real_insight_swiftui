//
//  SaveUserDataUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import UIKit

struct SaveUserDataUseCase {
    let repository: UserProfileRepository
    let authRepository: AuthenticationRepository
    
    func execute(fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) async throws {
        
        if let currentUser = try await authRepository.getCurrentUser(), let userId = currentUser.id {
            repository.saveUserData(userId: userId, fullname: fullname, username: username, location: location, bio: bio, selectedImage: selectedImage) { result in
                completion(result)
            }
        } else {
            completion(.failure(NSError(domain: "SaveUserDataUseCase", code: 404, userInfo: [NSLocalizedDescriptionKey: "User session not found"])))
        }
    }
}
