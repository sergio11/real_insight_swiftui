//
//  MainView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/2/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if viewModel.hasSession {
                        ContentView()
                            .environmentObject(viewModel)
                    } else {
                        OnboardingView()
                            .environmentObject(viewModel)
                    }
                }
            }
            .onAppear {
                Task { await viewModel.verifySession() }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
