//
//  EnterCodeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterCodeView: View {
    
    @State var timeRemaining = 60
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    viewModel.previousFlowStep()
                })
                VStack {
                    EnterCodeSection()
                    BottomSection(timeReamining: $timeRemaining)
                }
                .padding(.bottom, 40)
            }.onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    viewModel.previousFlowStep()
                }
            }
        }
    }
}

private struct EnterCodeSection: View {
    
    var body: some View {
        return VStack {
            VStack(alignment: .center, spacing: 8) {
                EnterCodeTextView()
                EnterCodeTextField()
            }
            .padding(.top, 50)
            Spacer()
        }
    }
}

private struct EnterCodeTextView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        Text("Enter the code we sent to + \(viewModel.country.phoneCode) \(viewModel.phoneNumber)")
            .foregroundColor(.white)
            .fontWeight(.medium)
            .font(.system(size: 16))
    }
}

private struct EnterCodeTextField: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        Text(".......")
            .foregroundColor(viewModel.otpText.isEmpty ? .gray: .white)
            .opacity(viewModel.otpText.isEmpty ? 0.8 : 0)
            .font(.system(size: 70))
            .frame(width: 210)
            .padding(.top, -40)
            .overlay(
                TextField("", text: $viewModel.otpText)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .heavy))
                    .keyboardType(.numberPad)
                    .limitText(6, binding: $viewModel.otpText)
                    .filterNumericCharacters(binding: $viewModel.otpText)
            )
    }
}

private struct BottomSection: View {
    
    @Binding var timeReamining: Int
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var isOtpNotEmpty: Binding<Bool> {
        Binding<Bool>(
            get: { !viewModel.otpText.isEmpty },
            set: { _ in }
        )
    }
    
    var body: some View {
        VStack {
            
            Button {
                dismiss()
            } label: {
                Text("Change the phone number")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            
            Button {
                Task { await self.viewModel.verifyOtp() }
            } label: {
                WhiteButtonView(buttonActive: isOtpNotEmpty, text: viewModel.otpText.count == 6 ? "Continue": "Resend in \(timeReamining) ")
            }
            .disabled(viewModel.otpText.isEmpty)
        }
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}
