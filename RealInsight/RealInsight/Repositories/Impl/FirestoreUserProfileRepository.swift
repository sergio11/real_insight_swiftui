//
//  FirestoreUserProfileRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Firebase

internal class FirestoreUserProfileRepository: UserProfileRepository {
    
    func saveUserData(userId: String, fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) {
            var userData: [String: Any] = [
                UserField.fullname: fullname,
                UserField.username: username ?? "",
                UserField.location: location ?? "",
                UserField.bio: bio ?? ""
            ]
            
        if let image = selectedImage {
            ImageUploader.uploadImage(image: image, type: .profile) { [weak self] url in
                userData[UserField.profileImageUrl] = url
                self?.uploadProfileData(userId: userId, data: userData, completion: completion)
            }
        } else {
            uploadProfileData(userId: userId, data: userData, completion: completion)
        }
    }
        
    private func uploadProfileData(userId: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(data) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}

private struct UserField {
    static let fullname = "fullname"
    static let username = "username"
    static let location = "location"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
