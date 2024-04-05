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
                    ContactsListView(contacts: $viewModel.friends, mainTitle: "MY FRIENDS (\(viewModel.friends.count))", noDataTitle: "No Pending Requests", noDataDescription: "You don't have any pending friend requests at the moment.", hideActions: true)
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }.onAppear {
            loadData()
        }.overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
    }
    
    private func loadData() {
        viewModel.loadCurrentUser()
        viewModel.loadFriends()
    }
}
