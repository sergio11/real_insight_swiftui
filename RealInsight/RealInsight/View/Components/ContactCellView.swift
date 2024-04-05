//
//  ContactCellView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/4/24.
//

import Foundation
import SwiftUI

struct ContactCellView: View {
    
    var user: User
    var hideActions: Bool = false
    var onAccept: (String) -> Void = { _ in }
    var onDiscard: (String) -> Void = { _ in }
    
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
                        .padding(.leading, -4)
                }
            }
            Spacer()
            if !hideActions {
                Button(action: {
                    onAccept(user.id)
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
                    onDiscard(user.id)
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.leading, 6)
                }
            }
        }
        .padding(.horizontal)
    }
    
}
