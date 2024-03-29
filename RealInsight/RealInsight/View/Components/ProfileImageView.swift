//
//  ProfileImageView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/3/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    
    var size: CGFloat = 60
    var cornerRadius: CGFloat = 30
    var profileImageUrl: String?
    var fullName: String?

    var body: some View {
        if let profileImageUrl = profileImageUrl, !profileImageUrl.isEmpty {
            KFImage(URL(string: profileImageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .cornerRadius(cornerRadius)
        } else {
            Circle()
                .frame(width: size, height: size)
                .cornerRadius(cornerRadius)
                .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                .overlay(
                    Text(fullName?.prefix(1).uppercased() ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: size / 2))
                )
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}
