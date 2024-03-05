//
//  ProfileImageView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/3/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    var profileImageUrl: String?
    var fullName: String?

    var body: some View {
        if let profileImageUrl = profileImageUrl {
            KFImage(URL(string: profileImageUrl))
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
        } else {
            Circle()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                .overlay(
                    Text(fullName?.prefix(1).uppercased() ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                )
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}
