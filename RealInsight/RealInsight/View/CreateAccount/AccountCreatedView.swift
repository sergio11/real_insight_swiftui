//
//  AccountCreatedView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct AccountCreatedView: View {
    
    @Binding var isAccountCreated: Bool
    
    var body: some View {
        ZStack {
            BackgroundImage(imageName: "account_created_background")
            VStack {
                MainContent()
                Actions(isAccountCreated: $isAccountCreated)
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
            Text("Your account has been created successfully!")
                 .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Text("You are now part of the RealInsight community. Start exploring and sharing genuine moments with others.")
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }.padding(.horizontal, 30)
    }
}

private struct Actions: View {
    
    @Binding var isAccountCreated: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                isAccountCreated = true
            }) {
                Text("Start Exploring!")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
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

struct AccountCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreatedView(isAccountCreated: .constant(false))
    }
}
