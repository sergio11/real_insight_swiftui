//
//  OnboardingView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            BackgroundImage()
            VStack {
                MainContent()
                Actions()
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
            Text("Your platform to connect with real people and gain valuable insights.")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }.padding(.horizontal, 30)
    }
}


private struct Actions: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Text("Join us now and discover the real connections you've been missing!")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            HStack(spacing: 20) {
                NavigationLink(destination: AuthenticationView()
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden()) {
                    Text("Create Account")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                            
                NavigationLink(destination: AuthenticationView()
                    .environmentObject(viewModel)
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

private struct BackgroundImage: View {
    var body: some View {
        Image("onboarding_background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
        Color.black.opacity(0.8)
            .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
