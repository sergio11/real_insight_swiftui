//
//  FirestoreStorageFilesDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import FirebaseStorage

/// A data source responsible for managing file uploads to Firestore Storage.
internal class FirestoreStorageFilesDataSourceImpl: StorageFilesDataSource {
    
    /// The path for storing profile images in Firestore Storage.
    private let profileImagesPath = "profile_images"
    /// The path for storing post images in Firestore Storage.
    private let postImagesPath = "post_images"

    /// Uploads an image to Firestore Storage asynchronously.
        ///
        /// - Parameters:
        ///   - imageData: The data of the image to be uploaded.
        ///   - type: The type of upload (profile image or post image).
        /// - Returns: A string representing the URL of the uploaded image.
        /// - Throws: An error if the upload operation fails.
    func uploadImage(imageData: Data, type: UploadType) async throws -> String {
        let filename = NSUUID().uuidString
        let folderPath: String
        switch type {
        case .profile:
            folderPath = profileImagesPath
        case .post:
            folderPath = postImagesPath
        }
        do {
            let ref = Storage.storage().reference(withPath: "/\(folderPath)/\(filename)")
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL().absoluteString
            return url
        } catch {
            print(error)
            throw error
        }
    }
}

