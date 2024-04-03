//
//  Suggestions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/2/24.
//

import SwiftUI

struct Suggestions: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    InviteFriendsView()
                    SuggestionsContacts()
                    Spacer()
                }.padding(.top, 20)
                
            }.padding(.top, 110)
        }
    }
}

private struct SuggestionsContacts: View {
    var body: some View {
        VStack {
            HStack {
                Text("ADD YOUR CONTACTS")
                    .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
            }
            ForEach(1..<16) { _ in
                SuggestionCellView()
            }
        }.padding(.top)
    }
}

struct Suggestions_Previews: PreviewProvider {
    static var previews: some View {
        Suggestions()
    }
}
