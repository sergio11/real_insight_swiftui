//
//  EditProfileViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory
import UIKit

class EditProfileViewModel: ObservableObject {
    
    @Injected(\.saveUserDataUseCase) private var saveUserDataUseCase: UpdateUserUseCase
    
    func saveUserData(fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?) async {
        
    }
}
