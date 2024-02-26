//
//  EnterPhoneNumberView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct EnterPhoneNumberView: View {
    
    @State var country = Country(isoCode: "US")
    @State var showCountryList = false
    @State var phoneNumber = ""
    @State var buttonActive = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("RealInsights")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                    }
                    Spacer()
                    
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
                                        Text("\(country.flag(country: country.isoCode))")
                                        +
                                        Text("+\(country.phoneCode)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12))
                                            .fontWeight(.bold)
                                    ).onTapGesture {
                                        self.showCountryList.toggle()
                                    }
                                
                                Text("Your Phone")
                                    .foregroundColor(phoneNumber.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                                    .fontWeight(.heavy)
                                    .font(.system(size: 40))
                                    .frame(width: 220)
                                    .overlay(
                                        TextField("", text: $phoneNumber)
                                            .foregroundColor(.white)
                                            .font(.system(size: 40))
                                            .fontWeight(.heavy)
                                    )
                            }
                            
                        }
                        .padding(.leading, UIScreen.main.bounds.width * 0.05)
                        Spacer()
                    }
                    .padding(.top, 50)
                        
                    }
                    
                    
                
                VStack {
                    
                    Spacer()
                    Text("By tapping \"Continue\", you agree to our Privacy Policy and Terms of Service.")
                        .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                    
                    Button {
                        
                    } label: {
                        WhiteButtonView(buttonActive: $buttonActive, text: "Continue")
                            .onChange(of: phoneNumber) { newValue in
                                buttonActive = !newValue.isEmpty
                            }
                    }
                    .disabled(phoneNumber.isEmpty)
                }.padding(.bottom, 20)
                
            }
        }
        .sheet(isPresented: $showCountryList) {
            SelectCountryView(countryChosen: $country)
        }
        .environment(\.colorScheme, .dark)
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
