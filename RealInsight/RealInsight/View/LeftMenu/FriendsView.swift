//
//  FriendsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/2/24.
//

import SwiftUI

struct FriendsView: View {
    
    @StateObject var viewModel = FriendsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    InviteFriendsView(authUserFullName: $viewModel.authUserFullName, authUserUsername: $viewModel.authUserUsername, authUserProfileImageUrl: $viewModel.authUserProfileImageUrl)
                    MyFriendsList(friends: $viewModel.friends)
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }.onAppear {
            viewModel.loadCurrentUser()
            viewModel.loadFriends()
        }.overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
    }
}

private struct MyFriendsList: View {
    
    @Binding var friends: [User]
    
    var body: some View {
        VStack {
            HStack {
                Text("MY FRIENDS (\(friends.count))")
                    .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                Spacer()
            }.padding(.horizontal)
            if friends.count > 0 {
                ForEach($friends) { friend in
                    FriendsCellView(user: friend)
                }
            } else {
                NoDataFoundView(title: "No Pending Requests", description: "You don't have any pending friend requests at the moment.")
            }
        }.padding(.top)
    }
}

private struct FriendsCellView: View {
    
    @Binding var user: User
    
    var body: some View {
        HStack {
            ProfileImageView(size: 65, cornerRadius: 65/2, profileImageUrl: user.profileImageUrl, fullName: user.fullname)
            VStack(alignment: .leading) {
                Text(user.fullname ?? user.username)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text(user.username)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .padding(.leading, 6)
            
        }.padding(.horizontal)
    }
}
