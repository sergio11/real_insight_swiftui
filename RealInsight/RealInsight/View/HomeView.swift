//
//  ContentView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State var width = UIScreen.main.bounds.width
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        HStack(spacing: 0) {
            LeftMenu(isOpened: $viewModel.isLeftMenuOpened)
                .frame(width: width)
            FeedView(isLeftMenuOpened: $viewModel.isLeftMenuOpened, isProfileOpened: $viewModel.isProfileOpened)
                .frame(width: width)
            ProfileView(isOpened: $viewModel.isProfileOpened)
                .frame(width: width)
        }
        .offset(x: viewModel.isLeftMenuOpened ? width : 0)
        .offset(x: viewModel.isProfileOpened ? -width : 0)
        .onChange(of: viewModel.isLeftMenuOpened) { newValue in simpleSuccess() }
        .onChange(of: viewModel.isProfileOpened) { newValue in simpleSuccess() }
    }
    
    private func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
