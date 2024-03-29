//
//  EnterNameView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct EnterNameView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                })
                VStack {
                    NameInputView()
                    Spacer()
                    ExplanationText(message: "The username you choose must be unique. It's what other users will use to identify you.")
                    ContinueButton()
                }
                .padding(.bottom, 40)
            }
        }
        .overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .errorAlert(isPresented: $viewModel.showAlert, message: viewModel.errorMessage)
    }
}

private struct NameInputView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Let's get started, what's your username?")
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                
                Text("Your username")
                    .foregroundColor(viewModel.username.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                    .fontWeight(.heavy)
                    .opacity(viewModel.username.isEmpty ? 1.0: 0)
                    .font(.system(size: 40))
                    .frame(width: 300)
                    .overlay(
                        TextField("", text: $viewModel.username)
                            .font(.system(size: 40, weight: .heavy))
                            .multilineTextAlignment(.center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(viewModel.showAlert ? Color.red : Color.clear, lineWidth: 2)
                            )
                    )
                    .padding(.top, 5)
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding(.top, 50)
    }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var isNameNotEmpty: Binding<Bool> {
        Binding<Bool>(
            get: { !viewModel.username.isEmpty },
            set: { _ in }
        )
    }
    
    var body: some View {
        Button {
            viewModel.verifyUsernameAvailability()
        } label: {
            WhiteButtonView(buttonActive: isNameNotEmpty, text: "Continue")
        }
        .disabled(viewModel.username.isEmpty)
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView()
    }
}
