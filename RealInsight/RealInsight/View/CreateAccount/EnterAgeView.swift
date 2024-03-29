//
//  EnterAgeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterAgeView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    viewModel.previousFlowStep()
                })
                VStack {
                    DateInputView()
                    Spacer()
                    ExplanationText(message: "Only to make sure you're old enough to use RealInsights.")
                    ContinueButton()
                }
                .padding(.bottom, 40)
            }
        }.errorAlert(isPresented: $viewModel.showAlert, message: viewModel.errorMessage)
    }
}

private struct DateInputView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Text("Hi \(viewModel.name), when's your birthday?")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                HStack(spacing: 4) {
                    InputField(title: "MM", value: $viewModel.birthdate.month)
                    InputField(title: "DD", value: $viewModel.birthdate.day)
                    InputField(title: "YYYY", value: $viewModel.birthdate.year)
                }
            }
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            Spacer()
        }.padding(.top, 50)
    }
}

private struct InputField: View {
    
    var title: String
    @Binding var value: String
    
    var body: some View {
        Text(title)
            .foregroundColor(value.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255) : Color.black)
            .fontWeight(.heavy)
            .font(.system(size: 40))
            .frame(width: title == "YYYY" ? 120 : 72)
            .overlay(
                TextField("", text: $value)
                    .foregroundColor(.white)
                    .font(.system(size: 45, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onReceive(Just(value)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.value = filtered
                        }
                        if title != "YYYY" && value.count > 2 {
                            self.value = String(value.prefix(2))
                        } else if title == "YYYY" && value.count > 4 {
                            self.value = String(value.prefix(4))
                        }
                    }
                )
        }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var isBirthdateValid: Binding<Bool> {
        Binding<Bool>(
            get: { viewModel.birthdate.hasDataValid() },
            set: { _ in }
        )
    }
        
    var body: some View {
        Button {
            viewModel.nextFlowStep()
        } label: {
            WhiteButtonView(buttonActive: isBirthdateValid, text: "Continue")
        }
        .disabled(!viewModel.birthdate.hasDataValid())
    }
}

struct EnterAgeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterAgeView()
    }
}
