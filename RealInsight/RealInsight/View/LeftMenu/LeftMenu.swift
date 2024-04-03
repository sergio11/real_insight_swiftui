//
//  LeftMenu.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI

struct LeftMenu: View {
    
    @Binding var isOpened: Bool
    
    @StateObject var viewModel = LeftMenuViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                LeftMenuTopView(isOpened: $isOpened)
                if viewModel.tabSelected == "Suggestions" {
                    SuggestionsView()
                } else if viewModel.tabSelected == "Friends" {
                    FriendsView()
                } else if viewModel.tabSelected == "Requests" {
                    RequestsView()
                }
                VStack {
                    Spacer()
                    TabBarMenuView(tabs: viewModel.tabs, selectedTab: $viewModel.tabSelected)
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
