//
//  FirestoreUserDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase

internal class FirestoreUserDataSource: UserDataSource {
    
    func saveUserData(data: SaveUserDTO) async throws -> UserDTO {
        let documentReference = Firestore.firestore()
            .collection("users").document(data.userId)
        do {
            try await documentReference.setData([
                "fullname": data.fullname,
                "username": data.username ?? "",
                "location": data.location ?? "",
                "bio": data.bio ?? "",
                "profileImageUrl": data.profileImageUrl ?? ""
            ], merge: true)

            return UserDTO(userId: data.userId, fullname: data.fullname, username: data.username, location: data.location, bio: data.bio, profileImageUrl: data.profileImageUrl)
        } catch {
            throw error
        }
    }
    
    func getUserById(userId: String) async throws -> UserDTO {
        let documentSnapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()

        guard let userData = documentSnapshot.data(),
             let fullname = userData["fullname"] as? String else {
            throw UserDataSourceError.userNotFound
        }

        let username = userData["username"] as? String
        let location = userData["location"] as? String
        let bio = userData["bio"] as? String
        let profileImageUrl = userData["profileImageUrl"] as? String

        return UserDTO(userId: userId, fullname: fullname, username: username, location: location, bio: bio, profileImageUrl: profileImageUrl)
    }
}
