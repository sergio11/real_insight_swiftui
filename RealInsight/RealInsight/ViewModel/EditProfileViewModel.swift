//
//  EditProfileViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory
import UIKit

class EditProfileViewModel: BaseUserViewModel {
    
    @Injected(\.updateUserUseCase) private var updateUserUseCase: UpdateUserUseCase
    
    func saveUserData(fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?) async {
        
    }
}
