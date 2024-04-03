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
                    FindingRequestList()
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }.onAppear {
            viewModel.loadCurrentUser()
        }
    }
}

private struct FindingRequestList: View {
    var body: some View {
        VStack {
            HStack {
                Text("FINDING REQUESTS (21)")
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
            
            RoundedRectangle(cornerRadius: 18)
                .frame(width: UIScreen.main.bounds.width * 0.95, height: 90)
                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                .overlay(
                    VStack(spacing: 8) {
                        HStack {
                            Spacer()
                            Text("No pending requests")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Text("You don't have any pending requests.")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                )
            
        }.padding(.top)
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsView()
    }
}
