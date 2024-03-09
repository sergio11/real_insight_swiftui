//
//  AuthenticationView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.authFlowStep {
            case .username:
                EnterNameView()
                    .environmentObject(viewModel)
            case .birthdate:
                EnterAgeView()
                    .environmentObject(viewModel)
            case .phoneNumber:
                EnterPhoneNumberView()
                    .environmentObject(viewModel)
            case .otp:
                EnterCodeView()
                    .environmentObject(viewModel)
            case .completed:
                ContentView()
                    .environmentObject(viewModel)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
