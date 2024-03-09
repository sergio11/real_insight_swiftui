//
//  FirestoreStorageFilesDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import FirebaseStorage

internal class FirestoreStorageFilesDataSource: StorageFilesDataSource {
    
    private let profileImagesPath = "profile_images"
    private let postImagesPath = "post_images"

    func uploadImage(imageData: Data, type: UploadType) async throws -> String {
        let filename = NSUUID().uuidString
        let folderPath: String
        switch type {
        case .profile:
            folderPath = profileImagesPath
        case .post:
            folderPath = postImagesPath
        }
        let ref = Storage.storage().reference(withPath: "/\(folderPath)/\(filename)")
        do {
            ref.putData(imageData)
            let url = try await ref.downloadURL().absoluteString
            return url
        } catch {
            throw error
        }
    }
}

