//
//  Feed.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    @Binding var mainMenu: String
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var cameraViewPressented: Bool = false
    
    init(feedViewModel: FeedViewModel, menu: Binding<String>) {
        self.feedViewModel = feedViewModel
        self._mainMenu = menu
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ZStack {
                    ScrollView {
                        VStack {
                            if !feedViewModel.blur {
                                VStack {
                                        VStack {
                                            BackImagePreview(backImageUrl: $feedViewModel.realInsight.backImageUrl)
                                            FrontImagePreview(frontImageUrl: $feedViewModel.realInsight.frontImageUrl)
                                        }
                                    PublicationInfo()
                                }
                            }
                            ForEach(feedViewModel.realInsightList, id: \.backImageUrl) { realInsight in
                                FeedCellView(realInsight: realInsight, blur: feedViewModel.blur, viewModel: FeedCellViewModel(realInsight: realInsight))
                                    .onAppear {
                                        if(feedViewModel.blur) {
                                            feedViewModel.blur = realInsight.userId != authViewModel.userUuid
                                        }
                                    }
                            }
                        }.padding(.top, 80)
                    }
                }
                VStack {
                    VStack {
                        TopBarView(mainMenu: $mainMenu, currentUser: $authViewModel.currentUser)
                        ProfileTabs()
                        Spacer()
                        if feedViewModel.blur {
                            PostButtonView(cameraViewPressented: $cameraViewPressented)
                        }
                    }
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
                }
            }
        }.fullScreenCover(isPresented: $cameraViewPressented) {
            Task { await feedViewModel.fetchData() }
        } content: {
            CameraView(viewModel: CameraViewModel.init(user: authViewModel.currentUser!))
        }
    }
}


private struct TopBarView: View {
    
    @Binding var mainMenu: String
    @Binding var currentUser: User?
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    self.mainMenu = "left"
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
                    self.mainMenu = "profile"
                }
            } label: {
                ProfileImageView(
                    size: 35,
                    cornerRadius: 17.5,
                    profileImageUrl: currentUser?.profileImageUrl,
                    fullName: currentUser?.fullname
                )
            }
        }
        .padding(.horizontal)
    }
}

private struct FrontImagePreview: View {
    
    @Binding var frontImageUrl: String
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: frontImageUrl))
                    .resizable()
                    .frame(width: 20, height: 40)
                    .scaledToFit()
                    .border(.black)
                    .cornerRadius(2)
                    .padding(.leading, 5)
                Spacer()
            }
            .padding(.top, 10)
            Spacer()
        }
    }
}

private struct BackImagePreview: View {
    
    @Binding var backImageUrl: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                KFImage(URL(string: backImageUrl))
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
            }
        }.frame(width: 100)
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
