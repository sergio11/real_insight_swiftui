//
//  AuthenticationViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/2/24.
//

import SwiftUI
import Firebase

class AuthenticationViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var birthdate = Birthdate(day: "", month: "", year: "")
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    @Published var otpText = ""
    @Published var navigationTag: String?
    @Published var isLoading: Bool = false
    @Published var verificationCode: String = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    
    func sendOtp() async {
        print("sendOtp isLoading: \(isLoading) CALLED!")
        guard !isLoading else {
            return
        }
        do {
            isLoading = true
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(country.phoneCode)\(phoneNumber)", uiDelegate: nil)
            print("sendOtp result \(result) CALLED!")
            DispatchQueue.main.async {
                self.isLoading = false
                self.verificationCode = result
                self.navigationTag = "VERIFICATION"
            }
        } catch {
            print("sendOtp handleError \(error.localizedDescription) CALLED!")
            handleError(error: error.localizedDescription)
        }
    }
    
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = error
            self.showAlert.toggle()
        }
    }
    
}
