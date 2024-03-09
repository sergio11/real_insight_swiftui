//
//  MainView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/2/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        Group {
            NavigationView {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if viewModel.hasSession {
                        HomeView()
                    } else {
                        OnboardingView(isAccountAuthenticated: $viewModel.hasSession)
                    }
                }
            }
        }
        .onAppear {
            Task { await viewModel.verifySession() }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
