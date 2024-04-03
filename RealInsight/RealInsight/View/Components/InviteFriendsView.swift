//
//  InviteFriendsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/3/24.
//

import SwiftUI

struct InviteFriendsView: View {
    
    @Binding var authUserFullName: String
    @Binding var authUserUsername: String
    @Binding var authUserProfileImageUrl: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 65)
            .foregroundColor(Color(red: 40/255, green: 40/255, blue: 35/255))
            .overlay(
                HStack {
                    ProfileImageView(size: 40, cornerRadius: 65/2, profileImageUrl: authUserProfileImageUrl, fullName: authUserFullName)
                    VStack(alignment: .leading) {
                        Text("Invite friends on RealInsights")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Text("realinsight/\(authUserUsername)")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                }
                .padding(.horizontal)
            )
            .padding(.horizontal)
    }
}
