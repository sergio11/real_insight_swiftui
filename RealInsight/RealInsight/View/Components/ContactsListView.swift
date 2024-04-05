//
//  ContactsListView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/4/24.
//

import SwiftUI

struct ContactsListView: View {
    
    @Binding var contacts: [User]
    var mainTitle: String
    var noDataTitle: String
    var noDataDescription: String
    var navigateActionTitle: String? = nil
    var hideActions: Bool = false
    var onAccept: (String) -> Void = { _ in }
    var onDiscard: (String) -> Void = { _ in }
    
    var body: some View {
        VStack {
            HStack {
                Text(mainTitle)
                    .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                Spacer()
                if let title = navigateActionTitle {
                    HStack {
                        Text(title)
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }.padding(.horizontal)
            if contacts.count > 0 {
                ForEach(contacts) { user in
                    ContactCellView(
                        user: user,
                        hideActions: hideActions,
                        onAccept: onAccept,
                        onDiscard: onDiscard
                    )
                }
            } else {
                NoDataFoundView(title: noDataTitle, description: noDataDescription)
            }
        }.padding(.top)
    }
}
