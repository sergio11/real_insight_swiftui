//
//  StorageFilesRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

enum UploadType {
    case profile
    case post
}

enum StorageFilesError: Error {
    case invalidImageData
    case uploadFailed
}

protocol StorageFilesRepository {
    func uploadImage(imageData: Data, type: UploadType) async throws -> String
}
