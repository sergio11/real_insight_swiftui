//
//  PhoneNumberInputView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct PhoneNumberInputView: View {
    
    @Binding var showCountryList: Bool
    @Binding var phoneNumber: String
    @Binding var country: Country
    var title: String
    var label: String
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
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
                    
                    Text(label)
                        .foregroundColor(phoneNumber.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .frame(width: 270)
                        .overlay(
                            TextField("", text: $phoneNumber)
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .filterNumericCharacters(binding: $phoneNumber)
                        )
                }.padding(.top, 5)
                
            }
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            Spacer()
        }
        .padding(.top, 50)
    }
}

struct PhoneNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputView(showCountryList: .constant(false), phoneNumber: .constant("955555666"), country: .constant(Country(isoCode: "US")), title: "Title", label: "Label")
    }
}
