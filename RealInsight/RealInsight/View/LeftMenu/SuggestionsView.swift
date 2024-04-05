//
//  SuggestionsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import SwiftUI

struct SuggestionsView: View {
    
    @StateObject var viewModel = SuggestionsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    InviteFriendsView(authUserFullName: $viewModel.authUserFullName, authUserUsername: $viewModel.authUserUsername, authUserProfileImageUrl: $viewModel.authUserProfileImageUrl)
                    ContactsListView(contacts: $viewModel.suggestions, mainTitle: "ADD YOUR CONTACTS", noDataTitle: "No Suggestions", noDataDescription: "There are no user suggestions available at the moment.", onAccept: viewModel.createFriendRequest, onDiscard: viewModel.discardSuggestion)
                    Spacer()
                }.padding(.top, 20)
            }.padding(.top, 110)
        }.onAppear {
            loadData()
        }.overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
    }
    
    private func loadData() {
        viewModel.loadSuggestions()
        viewModel.loadCurrentUser()
    }
}

struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView()
    }
}
