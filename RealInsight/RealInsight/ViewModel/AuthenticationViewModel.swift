//
//  AuthenticationViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

class AuthenticationViewModel: BaseViewModel {
    
    @Published var showCountryList = false
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    
}
