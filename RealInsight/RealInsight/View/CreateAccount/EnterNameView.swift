//
//  EnterNameView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct EnterNameView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                })
                NameInputView()
                ContinueButton()
            }
        }
    }
}

private struct NameInputView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Let's get started, what's your name?")
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                
                Text("Your name")
                    .foregroundColor(viewModel.name.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                    .fontWeight(.heavy)
                    .opacity(viewModel.name.isEmpty ? 1.0: 0)
                    .font(.system(size: 40))
                    .frame(width: 210)
                    .overlay(
                        TextField("", text: $viewModel.name)
                            .font(.system(size: 40, weight: .heavy))
                            .multilineTextAlignment(.center)
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
            get: { !viewModel.name.isEmpty },
            set: { _ in }
        )
    }
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                viewModel.nextFlowStep()
            } label: {
                WhiteButtonView(buttonActive: isNameNotEmpty, text: "Continue")
            }
        }
        .padding(.bottom, 40)
        .disabled(viewModel.name.isEmpty)
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView()
    }
}
