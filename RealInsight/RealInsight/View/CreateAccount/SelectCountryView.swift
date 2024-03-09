//
//  SelectCountryView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct SelectCountryView: View {
    
    @Binding var countryChosen: Country
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBar()
                CountryList(countryChosen: $countryChosen)
            }
            .environment(\.colorScheme, .dark)
        }
    }
}

private struct TopBar: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("Select Country")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.horizontal)
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
