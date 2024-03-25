//
//  CameraViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 1/3/24.
//

import Foundation
import SwiftUI
import Factory

class CameraViewModel: BaseViewModel {
    
    @Published var switchingCamera: Bool = false
    @Published var takePhotoClicked: Bool = false
    @Published var selectedBackImage: UIImage?
    @Published var selectedFrontImage: UIImage?
    @Published var backImage: Image?
    @Published var frontImage: Image?
    @Published var choseFromFront: Bool = false
    @Published var photoTaken: Bool = false
    
    @Injected(\.postRealInsightUseCase) private var postRealInsightUseCase: PostRealInsightUseCase
    
    func postRealInsight() {
        if let selectedBackImage = selectedBackImage,
           let selectedFrontImage = selectedFrontImage,
           let backImageData = selectedBackImage.jpegData(compressionQuality: 0.5),
           let frontImageData = selectedFrontImage.jpegData(compressionQuality: 0.5) {
            executeAsyncTask({ [unowned self] in
                try await self.postRealInsightUseCase.execute(backImageData: backImageData, frontImageData: frontImageData)
            }) { result in
                
            }
        }
    }
}
