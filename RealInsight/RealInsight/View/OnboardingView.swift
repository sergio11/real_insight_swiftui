//
//  OnboardingView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isAccountAuthenticated: Bool
    
    var body: some View {
        ZStack {
            BackgroundImage(imageName: "onboarding_background")
            VStack {
                MainContent()
                Actions(isAccountAuthenticated: $isAccountAuthenticated)
            }.padding(.horizontal, 30)
        }
        .statusBar(hidden: true)
    }
}


private struct MainContent: View {
    var body: some View {
        VStack {
            Image("onboarding_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .padding(.top, 50)
            Text("Welcome to RealInsight!")
                 .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Text("Explore RealInsight: where authenticity shines. Snap and share real moments, unfiltered, every day. Join a community that values genuine connections.")
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }.padding(.horizontal, 30)
    }
}


private struct Actions: View {
    
    @Binding var isAccountAuthenticated: Bool
    
    var body: some View {
        VStack {
            Text("Ready to be real online? Join RealInsight now!")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            HStack(spacing: 20) {
                NavigationLink(destination: CreateAccountView(isAccountCreated: $isAccountAuthenticated)
                    .navigationBarBackButtonHidden()) {
                    Text("Create Account")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                } 
                NavigationLink(destination: AuthenticationView(isAuthenticated: $isAccountAuthenticated)
                    .navigationBarBackButtonHidden()) {
                    Text("Get Started!")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 30)
            .padding(.top, 20)
            Text("Build with passion by dreamsoftware. Sergio Sánchez Sánchez © 2024")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
        }.padding(.horizontal, 30)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isAccountAuthenticated: .constant(false))
    }
}
