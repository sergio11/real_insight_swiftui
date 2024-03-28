//
//  Profile.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    @Binding var isOpened: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ProfileTopBarView(isOpened: $isOpened)
                VStack {
                    ProfileInfoView(authUserProfileImageUrl: $viewModel.authUserProfileImageUrl, authUserFullName: $viewModel.authUserFullName, authUserUsername: $viewModel.authUserUsername)
                    YourMemoriesView()
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(.white)
                                .opacity(0.07)
                                .frame(height: 230)
                            VStack {
                                ProfileMemoriesTitleView()
                                ProfileMemoriesView()
                                ViewAllMemoriesButton()
                            }
                            .padding(.top, -15)
                        }
                    }
                    UserLinkButton(authUserUsername: $viewModel.authUserUsername)
                    Spacer()
                }.padding(.top, 35)
            }
        }.onAppear {
            viewModel.loadCurrentUser()
        }
    }
}

private struct ProfileTopBarView: View {
    
    @Binding var isOpened: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation{
                        self.isOpened = false
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                Spacer()
                Text("Profile")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Spacer()
                NavigationLink {
                    SettingsView().navigationBarBackButtonHidden()
                } label:  {
                    ThreeDots(size: 4, color: .white)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

private struct ProfileInfoView: View {
    
    @Binding var authUserProfileImageUrl: String
    @Binding var authUserFullName: String
    @Binding var authUserUsername: String
    
    var body: some View {
        ProfileImageView(
            size: 130,
            cornerRadius: 75,
            profileImageUrl: authUserProfileImageUrl,
            fullName: authUserFullName
        )
        Text(authUserFullName)
            .foregroundColor(.white)
            .font(.system(size: 25))
            .fontWeight(.bold)
        Text(authUserUsername)
            .foregroundColor(.white)
            .fontWeight(.semibold)
    }
}

private struct ProfileMemoriesTitleView: View {
    var body: some View {
        HStack {
            Text("Last 14 days")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .padding(.top, 8)
            Spacer()
        }
        .padding(.leading)
    }
}

private struct ProfileMemoriesView: View {
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(1..<8) { num in
                    MemoryView(day: num)
                }
            }
            HStack(spacing: 4) {
                ForEach(1..<8) { num in
                    MemoryView(day: num+7)
                }
            }
            .padding(.top, -4)
        }
        .padding(.top, -4)
    }
}

private struct ViewAllMemoriesButton: View {
    var body: some View {
        Text("View all my memories")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 13))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 2)
                    .frame(width: 175, height: 20)
                    .opacity(0.5)
            )
            .padding(.top, 4)
    }
}

private struct UserLinkButton: View {
    
    @Binding var authUserUsername: String
    
    var body: some View {
        Text("Real/\(authUserUsername)")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 16))
            .padding(.top, 8)
    }
}

private struct YourMemoriesView: View {
    var body: some View {
        HStack {
            Text("Your memories")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 20))
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
                Text("Only visible to you")
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
            }
        }
        .padding(.horizontal)
        .padding(.top, 4)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isOpened: .constant(true))
    }
}
