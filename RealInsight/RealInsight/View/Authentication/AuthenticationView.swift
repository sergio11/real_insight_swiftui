//
//  AuthenticationView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var isAuthenticated: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                })
                VStack {
                    PhoneNumberInputView(showCountryList: $viewModel.showCountryList, phoneNumber: $viewModel.phoneNumber, country: $viewModel.country, title: "Sign in securely by providing your phone number", label: "Your Phone")
                    Spacer()
                    AgreementTextView()
                    ContinueButton(viewModel: viewModel)
                }.padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $viewModel.showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
        .sheet(isPresented: $viewModel.showEnterCodeView) {
            EnterCodeView(phoneCode: $viewModel.country.phoneCode, phoneNumber: $viewModel.phoneNumber, otpText: $viewModel.otpText, isLoading: $viewModel.isLoading, onBack: {
                viewModel.showEnterCodeView = false
            }, onVerifyOTP: {
                viewModel.signIn()
            })
        }
        .overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .onReceive(viewModel.$signInSuccess) { success in
            if success {
                isAuthenticated = true
            }
        }
        .environment(\.colorScheme, .dark)
    }
}

private struct ContinueButton: View {
    
    @StateObject var viewModel: AuthenticationViewModel
    
    var isPhoneNumberValid: Binding<Bool> {
        Binding<Bool>(
            get: { !viewModel.phoneNumber.isEmpty },
            set: { _ in }
        )
    }
    
    var body: some View {
        Button {
            viewModel.sendOtp()
        } label: {
            WhiteButtonView(buttonActive: isPhoneNumberValid, text: "Continue")
        }
        .disabled(viewModel.phoneNumber.isEmpty)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(isAuthenticated: .constant(false))
    }
}
