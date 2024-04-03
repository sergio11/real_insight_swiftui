//
//  FriendsCellView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/2/24.
//

import SwiftUI

struct FriendsCellView: View {
    
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
