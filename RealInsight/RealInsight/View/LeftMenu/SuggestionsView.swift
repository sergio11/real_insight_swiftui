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
                    InviteFriendsView()
                    SuggestionsContacts(suggestions: $viewModel.suggestions)
                    Spacer()
                }.padding(.top, 20)
                
            }.padding(.top, 110)
        }.onAppear {
            viewModel.loadSuggestions()
        }
    }
}

private struct SuggestionsContacts: View {
    
    @Binding var suggestions: [User]
    
    var body: some View {
        VStack {
            HStack {
                Text("ADD YOUR CONTACTS")
                    .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
            }
            ForEach(suggestions) { user in
                SuggestionCellView(user: user)
            }
        }.padding(.top)
    }
}


private struct SuggestionCellView: View {

    var user: User
    
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
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(red: 44/255, green: 44/255, blue: 46/255))
                .frame(width: 45, height: 25)
                .overlay(
                    Text("ADD")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                )
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .padding(.leading, 6)
        }
        .padding(.horizontal)
    }
}


struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView()
    }
}
