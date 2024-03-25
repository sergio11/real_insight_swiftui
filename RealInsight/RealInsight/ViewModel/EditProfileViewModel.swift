//
//  EditProfileViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory
import UIKit

class EditProfileViewModel: BaseViewModel {
    
    @Injected(\.updateUserUseCase) private var updateUserUseCase: UpdateUserUseCase
    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase: GetCurrentUserUseCase
    
    @Published var authUser: User?
    
    func saveUserData(fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?) async {
        
    }
}
