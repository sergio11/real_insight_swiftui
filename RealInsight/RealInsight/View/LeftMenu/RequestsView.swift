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
                    FindingRequestList(
                        requests: $viewModel.requests,
                        onConfirmRequest: viewModel.confirmFriendRequest,
                        onCancelRequest: viewModel.cancelFriendRequest
                    )
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }.onAppear {
            viewModel.loadCurrentUser()
            viewModel.loadRequests()
        }.overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
    }
}

private struct FindingRequestList: View {
    
    @Binding var requests: [User]
    
    var onConfirmRequest: (String) -> Void = { _ in }
    var onCancelRequest: (String) -> Void = { _ in }
    
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
                ForEach(requests) { user in
                    RequestCellView(
                        user: user,
                        onConfirmRequest: onConfirmRequest,
                        onCancelRequest: onCancelRequest
                    )
                }
            } else {
                NoDataFoundView(title: "No pending requests", description: "You don't have any pending requests.")
            }
        }.padding(.top)
    }
}

private struct RequestCellView: View {

    var user: User
    
    var onConfirmRequest: (String) -> Void = { _ in }
    var onCancelRequest: (String) -> Void = { _ in }
    
    var body: some View {
        HStack {
            ProfileImageView(size: 65, cornerRadius: 65/2, profileImageUrl: user.profileImageUrl, fullName: user.fullname)
            VStack(alignment: .leading) {
                Text(user.fullname ?? user.username)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                if let location = user.location {
                    Text(location)
                        .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text(user.username)
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .font(.system(size: 10))
                }
            }
            Spacer()
            Button(action: {
                onConfirmRequest(user.id)
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(red: 44/255, green: 44/255, blue: 46/255))
                    .frame(width: 45, height: 25)
                    .overlay(
                        Text("ADD")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                        )
            }
            Button(action: {
                onCancelRequest(user.id)
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                    .padding(.leading, 6)
            }
        }
        .padding(.horizontal)
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsView()
    }
}
