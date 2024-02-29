//
//  MainView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/2/24.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        Group {
            if !viewModel.hasSession() {
                MainAuthenticationView()
                    .environmentObject(viewModel)
            } else {
                if let user = viewModel.currentUser {
                    ContentView()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
