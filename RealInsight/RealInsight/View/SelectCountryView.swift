//
//  SelectCountryView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct SelectCountryView: View {
    
    @Binding var countryChosen: Country
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: { dismiss() },
                           title: "Select Country",
                           backButtomIcon: "xmark")
                CountryList(countryChosen: $countryChosen)
            }
            .environment(\.colorScheme, .dark)
        }
    }
}

private struct CountryList: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var countryChosen: Country
    var countries: [Country] = Country.allCountries
    
    var body: some View {
        VStack {
            VStack {
                List {
                    Section {
                        ForEach(countries, id: \.isoCode) { country in
                            HStack {
                                Text("\(country.flag(country: country.isoCode)) \(country.localizedName) (+\(country.phoneCode))")
                                Spacer()
                                if country.isoCode == countryChosen.isoCode {
                                    Image(systemName: "checkmark.circle")
                                }
                            }
                            .onTapGesture {
                                countryChosen = country
                                dismiss()
                            }
                        }
                    } header: {
                        Text("Suggested")
                            .padding(.leading, -8)
                            .font(.system(size: 12))
                    }
                }
            }
        }
        .padding(.top, 50)
    }
}

struct SelectCountryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCountryView(countryChosen: .constant(Country(isoCode: "US")))
    }
}
