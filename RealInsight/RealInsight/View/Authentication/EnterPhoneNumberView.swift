//
//  EnterPhoneNumberView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterPhoneNumberView: View {
    
    @State var showCountryList = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBar()
                VStack {
                    PhoneNumberInputView(viewModel: viewModel, showCountryList: $showCountryList)
                    Spacer()
                    AgreementText()
                    ContinueButton(viewModel: viewModel)
                }.padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
        .overlay {
            ProgressView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .environment(\.colorScheme, .dark)
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

private struct PhoneNumberInputView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    @Binding var showCountryList: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Text("Create you account using your phone number")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                HStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .frame(width: 75, height: 45)
                        .foregroundColor(.gray)
                        .overlay(
                            Text("\(viewModel.country.flag(country: viewModel.country.isoCode))")
                            +
                            Text("+\(viewModel.country.phoneCode)")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                        ).onTapGesture {
                            self.showCountryList.toggle()
                        }
                    
                    Text("Your Phone")
                        .foregroundColor(viewModel.phoneNumber.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .frame(width: 250)
                        .overlay(
                            TextField("", text: $viewModel.phoneNumber)
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .filterNumericCharacters(binding: $viewModel.phoneNumber)
                        )
                }.padding(.top, 5)
                
            }
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            Spacer()
        }
        .padding(.top, 50)
    }
}

private struct AgreementText: View {
    var body: some View {
        Text("By tapping \"Continue\", you agree to our Privacy Policy and Terms of Service.")
            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
            .fontWeight(.semibold)
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
    }
}

private struct ContinueButton: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var isPhoneNumberValid: Binding<Bool> {
        Binding<Bool>(
            get: { !viewModel.phoneNumber.isEmpty },
            set: { _ in }
        )
    }
    
    var body: some View {
        Button {
            Task { await viewModel.sendOtp() }
        } label: {
            WhiteButtonView(buttonActive: isPhoneNumberValid, text: "Continue")
        }
        .disabled(viewModel.phoneNumber.isEmpty)
    }
}


struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
