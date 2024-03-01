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
    @State private var frontImage: Image?
    @State private var choseFromFront: Bool = false
    @State private var photoTaken: Bool = false
    @ObservedObject private var viewModel: CameraViewModel
    
    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Text("RealInsight.")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    Text("04:57:11")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                    
                    ZStack(alignment: .topLeading) {
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
                                self.photoTaken.toggle()
                                self.switchingCamera.toggle()
                            } content: {
                                ImagePicker(image: $selectedFrontImage)
                            }
                        }.zIndex(1)
                        
                        if let image = backImage {
                            image.resizable()
                                .cornerRadius(12)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                                .scaledToFit()
                                .overlay(
                                    VStack {
                                        ProgressView()
                                        Text("Wait, wait, wait, now smile")
                                    }
                                        .foregroundColor(.white)
                                        .opacity(self.switchingCamera ? 1 : 0)
                                )
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                                .overlay(
                                    VStack {
                                        ProgressView()
                                        Text("Wait, wait, wait, now smile")
                                    }
                                        .foregroundColor(.white)
                                        .opacity(self.switchingCamera ? 1 : 0)
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
                    
                    
                    VStack {
                        if photoTaken {
                            Button {
                                onSend()
                            } label: {
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
                                    self.takePhotoClicked.toggle()
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
                    Spacer()
                }
                .padding(.top, 50)
            }
        }
    }
    
    private func onLoadBackImage() {
        guard let selectedBackImage = selectedBackImage else { return }
        backImage = Image(uiImage: selectedBackImage)
    }
    
    private func onLoadFrontImage() {
        guard let selectedFrontImage = selectedFrontImage else { return }
        frontImage = Image(uiImage: selectedFrontImage)
    }
    
    private func onSend() {
        if let selectedBackImage = selectedBackImage, let selectedFrontImage = selectedFrontImage {
            viewModel.takePhoto(backImage: selectedBackImage, frontImage: selectedFrontImage) { backImageUrl , frontImageUrl in
                do {
                    Task { await viewModel.postRealInsight(frontImageUrl: frontImageUrl, backImageUrl: backImageUrl)}
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
