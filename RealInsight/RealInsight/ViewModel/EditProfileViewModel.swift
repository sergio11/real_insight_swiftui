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

struct FormField {
    let key: String
    var label: String
    var placeholder: String
    var value: String
    var requireTextEditor: Bool = false
}

class EditProfileViewModel: BaseUserViewModel {
    
    let fullnameKey = "fullname"
    let usernameKey = "username"
    let bioKey = "bio"
    let locationKey = "location"
    
    @Published var imagePickerPressented = false
    @Published var selectedImage: UIImage?
    @Published var profileImage: Image?
    @Published var profileUpdated: Bool = false
    
    @Injected(\.updateUserUseCase) private var updateUserUseCase: UpdateUserUseCase
    
    @Published var fields: [FormField] = []
    
    override func onCurrentUserLoaded(user: User) {
        super.onCurrentUserLoaded(user: user)
        fields = [
            FormField(key: fullnameKey, label: "Full name", placeholder: "Enter your full name", value: user.fullname ?? ""),
            FormField(key: usernameKey, label: "Username", placeholder: "Enter your username", value: user.username),
            FormField(key: bioKey, label: "Bio", placeholder: "Write a short bio about yourself", value: user.bio ?? "", requireTextEditor: true),
            FormField(key: locationKey, label: "Location", placeholder: "Enter your location", value: user.location ?? "")
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
        let fullname = fields.first(where: { $0.key == fullnameKey })?.value ?? ""
        let username = fields.first(where: { $0.key == usernameKey })?.value
        let location = fields.first(where: { $0.key == locationKey })?.value
        let bio = fields.first(where: { $0.key == bioKey })?.value
        
        // Update user data
        executeAsyncTask({
            return try await self.updateUserUseCase.execute(params: UpdateUserParams(
                fullname: fullname,
                username: username,
                location: location,
                bio: bio,
                selectedImage: imageData
            ))
        }, completion: { [weak self] result in
            if case .success = result {
                self?.profileUpdated = true
            }
        })
    }
}
