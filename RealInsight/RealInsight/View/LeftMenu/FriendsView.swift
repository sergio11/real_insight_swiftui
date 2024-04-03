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
                    MyFriendsList()
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }.onAppear {
            viewModel.loadCurrentUser()
        }
    }
}

private struct MyFriendsList: View {
    var body: some View {
        VStack {
            HStack {
                Text("MY FRIENDS (21)")
                    .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                Spacer()
            }.padding(.horizontal)
            
            ForEach(1..<16) { _ in
                FriendsCellView()
            }
            
        }.padding(.top)
    }
}
