//
//  EditProfileViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory
import UIKit
import SwiftUI

class EditProfileViewModel: BaseUserViewModel {
    
    let fullnameKey = "fullname"
    let usernameKey = "username"
    let bioKey = "bio"
    let locationKey = "location"
    let birthdateKey = "birthdate"
    
    @Published var imagePickerPressented = false
    @Published var selectedImage: UIImage?
    @Published var profileImage: Image?
    @Published var profileUpdated: Bool = false
    @Published var fields: [FormField] = []
    
    @Injected(\.updateUserUseCase) private var updateUserUseCase: UpdateUserUseCase
    
    override func onCurrentUserLoaded(user: User) {
        super.onCurrentUserLoaded(user: user)
        fields = [
            TextFormField(key: fullnameKey, label: "Full name", placeholder: "Enter your full name", value: user.fullname ?? ""),
            TextFormField(key: usernameKey, label: "Username", placeholder: "Enter your username", value: user.username),
            TextAreaFormField(key: bioKey, label: "Bio", placeholder: "Write a short bio about yourself", value: user.bio ?? ""),
            TextFormField(key: locationKey, label: "Location", placeholder: "Enter your location", value: user.location ?? ""),
            DatePickerFormField(key: birthdateKey, label: "Birthdate", placeholder: "Enter your birthdate", value: user.birthdate.toDate() ?? Date())
        ]
    }
    
    func saveUserData() {
        // Check if an image is selected
        guard let selectedImage = selectedImage else {
            // If no image is selected, update user data without the image
            updateUserWithImageData(nil)
            return
        }
        
        // Convert the selected image to data
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            // Handle the error of image conversion
            return
        }
        
        // Update user data with the image
        updateUserWithImageData(imageData)
    }

    private func updateUserWithImageData(_ imageData: Data?) {
        // Get the values of the fields
        let fullname = fields.value(for: fullnameKey, defaultValue: "")
        let username = fields.value(for: usernameKey, defaultValue: "")
        let location = fields.value(for: locationKey, defaultValue: "")
        let birthdate = fields.value(for: birthdateKey, defaultValue: Date())
        let bio = fields.value(for: bioKey, defaultValue: "")
        
        // Update user data
        executeAsyncTask({
            return try await self.updateUserUseCase.execute(params: UpdateUserParams(
                fullname: fullname,
                username: username,
                location: location,
                bio: bio,
                birthdate: birthdate.formattedString(),
                selectedImage: imageData
            ))
        }, completion: { [weak self] result in
            if case .success = result {
                self?.profileUpdated = true
            }
        })
    }
}
