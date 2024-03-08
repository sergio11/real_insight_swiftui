//
//  UserProfileRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import UIKit

protocol UserProfileRepository {
    func saveUserData(userId: String, fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?, completion: @escaping (Result<Void, Error>) -> Void)
}
