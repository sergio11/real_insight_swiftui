//
//  CreateAccountView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Binding var isAccountCreated: Bool
    @ObservedObject var viewModel = CreateAccountViewModel()
    
    var body: some View {
        switch viewModel.accountFlowStep {
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
            AccountCreatedView(isAccountCreated: $isAccountCreated)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(isAccountCreated: .constant(false))
    }
}
