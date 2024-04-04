//
//  Feed.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    @Binding var isLeftMenuOpened: Bool
    @Binding var isProfileOpened: Bool

    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ZStack {
                    ScrollView {
                        VStack {
                            if viewModel.hasOwnRealInsightPublished {
                                VStack {
                                    PublicationPreview(backImageUrl: $viewModel.backImageUrl, frontImageUrl: $viewModel.frontImageUrl)
                                    PublicationInfo()
                                }
                            }
                            ForEach(viewModel.realInsightList, id: \.backImageUrl) { realInsight in
                                FeedCellView(
                                    realInsight: realInsight,
                                    hasOwnRealInsightPublished: viewModel.hasOwnRealInsightPublished,
                                    onPostLateRealInsight: {
                                        viewModel.cameraViewPressented.toggle()
                                    })
                            }
                        }.padding(.top, 80)
                    }
                    VStack {
                        VStack {
                            MainTopBarView(isLeftMenuOpened: $isLeftMenuOpened, isProfileOpened: $isProfileOpened, authUserProfileImageUrl: $viewModel.authUserProfileImageUrl, authUserFullName: $viewModel.authUserFullName)
                            ProfileTabs()
                            Spacer()
                            if !viewModel.hasOwnRealInsightPublished {
                                PostButtonView(cameraViewPressented: $viewModel.cameraViewPressented)
                            }
                        }
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
                    }
                }
            }
        }.fullScreenCover(isPresented: $viewModel.cameraViewPressented) {
            viewModel.fetchData()
        } content: {
            CameraView()
        }.onAppear {
            onFetchData()
        }
    }
    
    private func onFetchData() {
        viewModel.fetchData()
        viewModel.loadCurrentUser()
    }
}


private struct MainTopBarView: View {
    
    @Binding var isLeftMenuOpened: Bool
    @Binding var isProfileOpened: Bool
    @Binding var authUserProfileImageUrl: String
    @Binding var authUserFullName: String
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    self.isLeftMenuOpened = true
                }
            } label: {
                Image(systemName: "person.2.fill")
                    .foregroundColor(.white)
            }
            Spacer()
            Text("RealInsight.")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 22))
            Spacer()
            Button {
                withAnimation {
                    self.isProfileOpened = true
                }
            } label: {
                ProfileImageView(
                    size: 35,
                    cornerRadius: 17.5,
                    profileImageUrl: authUserProfileImageUrl,
                    fullName: authUserFullName
                )
            }
        }
        .padding(.horizontal)
    }
}

private struct PublicationPreview: View {
    
    @Binding var backImageUrl: String
    @Binding var frontImageUrl: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            KFImage(URL(string: backImageUrl))
                .resizable()
                .frame(width: 100, height: 150)
                .scaledToFit()
                .cornerRadius(5)
                
            KFImage(URL(string: frontImageUrl))
                .resizable()
                .frame(width: 25, height: 40)
                .scaledToFit()
                .border(.black)
                .cornerRadius(2)
                .padding(5)
                .offset(x: 5, y: 10)
        }
    }
}


private struct PublicationInfo: View {
    var body: some View {
        VStack {
            Text("Add a caption...")
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text("View comment")
                .foregroundColor(.gray)
            HStack {
                Text("Location * 1 hr late")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                ThreeDots(size: 3, color: .gray)
            }
        }
    }
}

private struct ProfileTabs: View {
    var body: some View {
        HStack {
            Text("My friends")
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text("Discovery")
                .foregroundColor(.gray)
        }
    }
}

private struct PostButtonView: View {
    
    @Binding var cameraViewPressented: Bool
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "circle")
                    .font(.system(size: 80))
                Text("Post a late RealInsight.")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding(.bottom, 12)
            .onTapGesture {
                cameraViewPressented.toggle()
            }
        }
    }
}
