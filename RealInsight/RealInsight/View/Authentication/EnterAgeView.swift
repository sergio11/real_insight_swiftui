//
//  EnterAgeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterAgeView: View {
    
    @Binding var birthdate: Birthdate
    @Binding var name: String
    @Binding var buttonClicked: Bool
    
    @State var buttonActive = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBar()
                VStack(alignment: .center, spacing: 8) {
                    GreetingText(name: $name)
                    DateInputView(birthdate: $birthdate)
                    Spacer()
                }
                .padding(.top, 50)
                VStack {
                    Spacer()
                    ExplanationText()
                    ContinueButton(buttonActive: $buttonActive, buttonClicked: $buttonClicked, birthdate: $birthdate)
                }.padding(.bottom, 10)
            }
        }
    }
}

private struct TopBar: View {
    var body: some View {
        VStack {
            HStack {
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
    
    @Binding var name: String
    
    var body: some View {
        Text("Hi \(name), when's your birthday?")
            .foregroundColor(.white)
            .fontWeight(.heavy)
            .font(.system(size: 16))
    }
}

private struct DateInputView: View {
    @Binding var birthdate: Birthdate
    
    var body: some View {
        HStack(spacing: 4) {
            InputField(title: "MM", value: $birthdate.month)
            InputField(title: "DD", value: $birthdate.day)
            InputField(title: "YYYY", value: $birthdate.year)
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
    
    @Binding var buttonActive: Bool
    @Binding var buttonClicked: Bool
    @Binding var birthdate: Birthdate
        
    var body: some View {
        Button {
            buttonClicked = true
        } label: {
            WhiteButtonView(buttonActive: $buttonActive, text: "Continue")
                .onChange(of: birthdate) { newValue in
                    buttonActive = newValue.hasDataValid()
                }
        }
    }
}

struct EnterAgeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterAgeView(birthdate: .constant(Birthdate(day: "", month: "", year: "")), name: .constant(""), buttonClicked: .constant(true))
    }
}
