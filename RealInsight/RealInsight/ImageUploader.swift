//
//  ImageUploader.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 1/3/24.
//

import Foundation
import Firebase
import FirebaseStorage


enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference {
        let filename = NSUUID().uuidString
        let folterPath: String
        switch self {
            case .profile:
                folterPath = "profile_images"
                break
            case .post:
                folterPath = "post_images"
                break
        }
        return Storage.storage().reference(withPath: "/\(folterPath)/\(filename)")
    }
    
    
}

struct ImageUploader {
    
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
        ref.putData(imageData) { (_, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            ref.downloadURL { url, err in
                guard let url = url?.absoluteString else { return }
                completion(url)
            }
        }
    }
}
