//
//  EnterAgeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterAgeView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBar()
                VStack(alignment: .center, spacing: 8) {
                    GreetingText()
                    DateInputView()
                    Spacer()
                }
                .padding(.top, 50)
                VStack {
                    Spacer()
                    ExplanationText()
                    ContinueButton()
                }.padding(.bottom, 40)
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

private struct GreetingText: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Hi \(viewModel.name), when's your birthday?")
            .foregroundColor(.white)
            .fontWeight(.heavy)
            .font(.system(size: 16))
    }
}

private struct DateInputView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            InputField(title: "MM", value: $viewModel.birthdate.month)
            InputField(title: "DD", value: $viewModel.birthdate.day)
            InputField(title: "YYYY", value: $viewModel.birthdate.year)
        }
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

private struct ExplanationText: View {
    var body: some View {
        Text("Only to make sure you're old enough to use RealInsights.")
            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
            .fontWeight(.semibold)
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var isBirthdateValid: Binding<Bool> {
        Binding<Bool>(
            get: { viewModel.birthdate.hasDataValid() },
            set: { _ in }
        )
    }
        
    var body: some View {
        Button {
            viewModel.nextAuthFlowStep()
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
