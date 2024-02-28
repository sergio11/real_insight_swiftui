//
//  MainAuthenticationView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/2/24.
//

import SwiftUI

struct MainAuthenticationView: View {
    
    @State private var nameButtonClicked = false
    @State private var ageButtonClicked = false
    @State private var phoneNumberButtonClicked = false
    
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView {
            if !nameButtonClicked {
                EnterNameView(buttonClicked: $nameButtonClicked)
                    .environmentObject(viewModel)
            } else if nameButtonClicked && !ageButtonClicked {
                EnterAgeView(buttonClicked: $ageButtonClicked)
                    .environmentObject(viewModel)
            } else if nameButtonClicked && ageButtonClicked && !phoneNumberButtonClicked {
                EnterPhoneNumberView(buttonClicked: $phoneNumberButtonClicked)
                    .environmentObject(viewModel)
            }
            
        }
    }
}

struct MainAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        MainAuthenticationView()
    }
}
