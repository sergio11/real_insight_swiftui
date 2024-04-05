//
//  RequestsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct RequestsView: View {
    
    @StateObject var viewModel = RequestsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    InviteFriendsView(authUserFullName: $viewModel.authUserFullName, authUserUsername: $viewModel.authUserUsername, authUserProfileImageUrl: $viewModel.authUserProfileImageUrl)
                    ContactsListView(contacts: $viewModel.requests, mainTitle: "FINDING REQUESTS (\(viewModel.requests.count))", noDataTitle: "No pending requests", noDataDescription: "You don't have any pending requests.", navigateActionTitle: "Sent", onAccept: viewModel.confirmFriendRequest, onDiscard: viewModel.cancelFriendRequest)
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
        viewModel.loadRequests()
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsView()
    }
}
