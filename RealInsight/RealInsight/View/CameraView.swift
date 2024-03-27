//
//  CameraView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 1/3/24.
//

import SwiftUI

struct CameraView: View {
    
    @ObservedObject var viewModel = CameraViewModel()
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                })
                VStack {
                    MainTitleView()
                    ZStack(alignment: .topLeading) {
                        FrontImageView(viewModel: viewModel)
                        BackImageView(viewModel: viewModel)
                    }
                    CameraActionsView(viewModel: viewModel) {
                        onSend()
                    }
                    Spacer()
                }
                .padding(.top, 50)
            }
        }
    }
    
    
    private func onSend() {
        viewModel.postRealInsight()
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
    
    @ObservedObject var viewModel: CameraViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { g in
            VStack {
                if viewModel.frontImage != nil {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 125, height: 165)
                            .overlay(
                                VStack {
                                    if let imageFront = viewModel.frontImage {
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
            }.sheet(isPresented: $viewModel.choseFromFront) {
                onLoadFrontImage()
                viewModel.photoTaken.toggle()
                viewModel.switchingCamera.toggle()
            } content: {
                ImagePicker(image: $viewModel.selectedFrontImage)
            }
            .overlay {
                LoadingView()
                    .opacity(viewModel.isLoading ? 1 : 0)
            }.onReceive(viewModel.$postUploaded) { success in
                if success {
                    dismiss()
                }
            }
        }.zIndex(1)
    }
    
    private func onLoadFrontImage() {
        guard let selectedFrontImage = viewModel.selectedFrontImage else { return }
        viewModel.frontImage = Image(uiImage: selectedFrontImage)
    }
}

private struct BackImageView: View {
    
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        if let image = viewModel.backImage {
            image.resizable()
                .cornerRadius(12)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                .scaledToFit()
                .overlay(
                    LoadingView(message: "Wait, wait, wait, now smile")
                        .opacity(viewModel.switchingCamera ? 1 : 0)
                )
        } else {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                .overlay(
                    LoadingView(message: "Wait, wait, wait, now smile")
                        .opacity(viewModel.switchingCamera ? 1 : 0)
                ).sheet(isPresented: $viewModel.takePhotoClicked){
                    onLoadBackImage()
                    viewModel.switchingCamera.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        viewModel.choseFromFront.toggle()
                    }
                } content: {
                    ImagePicker(image: $viewModel.selectedBackImage)
                }
        }
    }
    
    private func onLoadBackImage() {
        guard let selectedBackImage = viewModel.selectedBackImage else { return }
        viewModel.backImage = Image(uiImage: selectedBackImage)
    }
}

private struct CameraActionsView: View {
    
    @ObservedObject var viewModel: CameraViewModel
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            if viewModel.photoTaken {
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
                .disabled(viewModel.isLoading)
            } else {
                HStack(alignment: .center, spacing: 18) {
                    Image(systemName: "bolt.slash.fill")
                        .font(.system(size: 28))
                    Button {
                        viewModel.takePhotoClicked.toggle()
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
