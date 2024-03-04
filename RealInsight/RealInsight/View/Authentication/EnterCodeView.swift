//
//  EnterCodeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterCodeView: View {
    
    @State var buttonActive: Bool = false
    @State var timeRemaining = 60
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBar()
                VStack {
                    EnterCodeSection()
                    BottomSection(buttonActive: $buttonActive, timeReamining: $timeRemaining)
                }
                .padding(.bottom, 40)
            }.onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    buttonActive = false
                    viewModel.previousAuthFlowStep()
                }
            }
        }
    }
}

private struct TopBar: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.previousAuthFlowStep()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }.padding(.leading)
                Spacer()
                Text("RealInsights.")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                Spacer()
            }
            Spacer()
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
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Enter the code we sent to + \(viewModel.country.phoneCode) \(viewModel.phoneNumber)")
            .foregroundColor(.white)
            .fontWeight(.medium)
            .font(.system(size: 16))
    }
}

private struct EnterCodeTextField: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
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
    
    @Binding var buttonActive: Bool
    @Binding var timeReamining: Int
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @Environment(\.dismiss) var dismiss
    
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
                if buttonActive {
                    Task { await self.viewModel.verifyOtp() }
                }
            } label: {
                WhiteButtonView(buttonActive: $buttonActive, text: viewModel.otpText.count == 6 ? "Continue": "Resend in \(timeReamining) ")
            }
            .disabled(!buttonActive)
            .onChange(of: viewModel.otpText) { newValue in
                buttonActive = !newValue.isEmpty
            }
        }
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}
