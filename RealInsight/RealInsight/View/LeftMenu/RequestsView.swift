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
                    FindingRequestList(requests: $viewModel.requests)
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }.onAppear {
            viewModel.loadCurrentUser()
            viewModel.loadRequests()
        }
    }
}

private struct FindingRequestList: View {
    
    @Binding var requests: [User]
    
    var body: some View {
        VStack {
            HStack {
                Text("FINDING REQUESTS (\(requests.count))")
                    .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                Spacer()
                
                HStack {
                    Text("Sent")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                
            }.padding(.horizontal)
            
            if requests.count > 0 {
                
            } else {
                NoDataFoundView(title: "No pending requests", description: "You don't have any pending requests.")
            }
        }.padding(.top)
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsView()
    }
}
