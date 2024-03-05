//
//  CameraViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 1/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class CameraViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func postRealInsight(backImage: UIImage, frontImage: UIImage, completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: backImage, type: .post) { urlBackImage in
            ImageUploader.uploadImage(image: frontImage, type: .post) { [unowned self] urlFrontImage in
                guard let userId = self.user.id else { return }
                let userFullname = self.user.fullname
                let db = Firestore.firestore()
                let dateString = Date().formattedString
                print(dateString)
                db.collection("posts")
                    .document(dateString)
                    .collection("reals_insights")
                    .document(userId)
                    .setData([
                        "frontImageUrl": urlFrontImage,
                        "backImageUrl": urlBackImage,
                        "userId": userId,
                        "username": userFullname
                    ]) { err in
                        completion(err)
                    }
            }
        }
        
    }
}
