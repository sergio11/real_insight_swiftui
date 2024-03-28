//
//  LeftMenu.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI

struct LeftMenu: View {

    @State var menu = "Suggestions"
    
    @Binding var isOpened: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                LeftMenuTopView(isOpened: $isOpened)
                if menu == "Suggestions" {
                    Suggestions()
                } else if menu == "Friends" {
                    FriendsView()
                } else if menu == "Requests" {
                    RequestsView()
                }
                VStack {
                    Spacer()
                    TabBarMenuView(tabs: ["Suggestions", "Friends", "Requests"], selectedTab: $menu)
                }
            }
            
        }
        
    }
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu(isOpened: .constant(true))
    }
}
