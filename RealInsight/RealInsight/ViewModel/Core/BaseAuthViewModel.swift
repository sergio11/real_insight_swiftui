//
//  BaseAuthViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 27/3/24.
//

import Foundation

class BaseAuthViewModel: BaseViewModel {
    
    @Published var showCountryList = false
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    @Published var otpText = ""
    
    internal var verificationCode: String = ""
}
