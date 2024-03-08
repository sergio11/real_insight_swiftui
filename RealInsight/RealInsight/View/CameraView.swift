//
//  CameraView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 1/3/24.
//

import SwiftUI

struct CameraView: View {
    
    @State private var switchingCamera: Bool = false
    @State private var takePhotoClicked: Bool = false
    @State private var selectedBackImage: UIImage?
    @State private var selectedFrontImage: UIImage?
    @State private var backImage: Image?
    
    @State private var choseFromFront: Bool = false
    @State private var photoTaken: Bool = false
    @ObservedObject private var viewModel: CameraViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView()
                VStack {
                    MainTitleView()
                    ZStack(alignment: .topLeading) {
                        FrontImageView(photoTaken: $photoTaken, switchingCamera: $switchingCamera, takePhotoClicked: $takePhotoClicked, choseFromFront: $choseFromFront, selectedFrontImage: $selectedFrontImage)
                        BackImageView(switchingCamera: $switchingCamera, takePhotoClicked: $takePhotoClicked, choseFromFront: $choseFromFront, selectedBackImage: $selectedBackImage)
                    }
                    CameraActionsView(photoTaken: $photoTaken, takePhotoClicked: $takePhotoClicked) {
                        onSend()
                    }
                    Spacer()
                }
                .padding(.top, 50)
            }
        }
    }
    
    
    private func onSend() {
        if let selectedBackImage = selectedBackImage, let selectedFrontImage = selectedFrontImage {
            viewModel.postRealInsight(backImage: selectedBackImage, frontImage: selectedFrontImage) { _ in 
                dismiss()
            }
        }
    }
}

private struct TopBarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                Spacer()
                Text("RealInsight.")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                Spacer()
            }.padding(.horizontal)
            Spacer()
        }
    }
}

private struct MainTitleView: View {
    var body: some View {
        Text("04:57:11")
            .foregroundColor(.white)
            .font(.system(size: 20))
            .fontWeight(.heavy)
    }
}

private struct FrontImageView: View {
    
    @Binding var photoTaken: Bool
    @Binding var switchingCamera: Bool
    @Binding var takePhotoClicked: Bool
    @Binding var choseFromFront: Bool
    @Binding var selectedFrontImage: UIImage?
    
    @State private var frontImage: Image?
    
    var body: some View {
        GeometryReader { g in
            VStack {
                if frontImage != nil {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 125, height: 165)
                            .overlay(
                                VStack {
                                    if let imageFront = frontImage {
                                        imageFront.resizable()
                                            .cornerRadius(8)
                                            .frame(width: 120, height: 160)
                                            .scaledToFit()
                                    }
                                }
                            )
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 18)
                }
                Spacer()
            }.sheet(isPresented: $choseFromFront) {
                onLoadFrontImage()
                photoTaken.toggle()
                switchingCamera.toggle()
            } content: {
                ImagePicker(image: $selectedFrontImage)
            }
        }.zIndex(1)
    }
    
    private func onLoadFrontImage() {
        guard let selectedFrontImage = selectedFrontImage else { return }
        frontImage = Image(uiImage: selectedFrontImage)
    }
}

private struct BackImageView: View {
    
    @Binding var switchingCamera: Bool
    @Binding var takePhotoClicked: Bool
    @Binding var choseFromFront: Bool
    @Binding var selectedBackImage: UIImage?

    @State private var backImage: Image?
    
    var body: some View {
        if let image = backImage {
            image.resizable()
                .cornerRadius(12)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                .scaledToFit()
                .overlay(
                    UploadProgressView(switchingCamera: $switchingCamera)
                )
        } else {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                .overlay(
                    UploadProgressView(switchingCamera: $switchingCamera)
                ).sheet(isPresented: $takePhotoClicked){
                    onLoadBackImage()
                    self.switchingCamera.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.choseFromFront.toggle()
                    }
                } content: {
                    ImagePicker(image: $selectedBackImage)
                }
        }
    }
    
    private func onLoadBackImage() {
        guard let selectedBackImage = selectedBackImage else { return }
        backImage = Image(uiImage: selectedBackImage)
    }
}

private struct CameraActionsView: View {
    
    @Binding var photoTaken: Bool
    @Binding var takePhotoClicked: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            if photoTaken {
                Button(action: action) {
                    HStack {
                        Text("SEND")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .black))
                        Image(systemName: "location.north.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .black))
                            .rotationEffect(.degrees(90))
                    }
                }
            } else {
                HStack(alignment: .center, spacing: 18) {
                    Image(systemName: "bolt.slash.fill")
                        .font(.system(size: 28))
                    Button {
                        takePhotoClicked.toggle()
                    } label: {
                        Image(systemName: "circle")
                            .font(.system(size: 70))
                    }
                    
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 24))
                }.foregroundColor(.white)
            }
        }
        .offset(y: -20)
    }
}

private struct UploadProgressView: View {
    
    @Binding var switchingCamera: Bool
    
    var body: some View {
        VStack {
            ProgressView()
            Text("Wait, wait, wait, now smile")
        }
            .foregroundColor(.white)
            .opacity(switchingCamera ? 1 : 0)
    }
}
