//
//  ContentView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    @State var width = UIScreen.main.bounds.width
    @State var menu = "feed"
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                LeftMenu(mainMenu: $menu)
                    .frame(width: width)
                FeedView(mainMenu: $menu)
                    .frame(width: width)
                ProfileView(mainMenu: $menu)
                    .frame(width: width)
            }
            .offset(x: menu == "left" ? width : 0)
            .offset(x: menu == "profile" ? -width : 0)
            .onChange(of: menu) { newValue in simpleSuccess() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
