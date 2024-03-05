//
//  InviteFriendsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/3/24.
//

import SwiftUI

struct InviteFriendsView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 65)
            .foregroundColor(Color(red: 40/255, green: 40/255, blue: 35/255))
            .overlay(
                HStack {
                    Image("example")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        Text("Invite friends on RealInsights")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Text("realinsight/dreamsoftware")
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

struct InviteFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        InviteFriendsView()
    }
}
