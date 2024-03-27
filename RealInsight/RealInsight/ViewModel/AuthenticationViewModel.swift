//
//  AuthenticationViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI
import Factory

class AuthenticationViewModel: BaseViewModel {
    
    @Published var showCountryList = false
    @Published var showEnterCodeView = false
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    @Published var otpText = ""
    @Published var signInSuccess = false
    
    private var verificationCode: String = ""
    
    @Injected(\.sendOtpUseCase) private var sendOtpUseCase: SendOtpUseCase
    @Injected(\.signInUseCase) private var signInUseCase: SignInUseCase
    
    func sendOtp() {
        guard !isLoading else { return }
        executeAsyncTask {
            return try await self.sendOtpUseCase.execute(phoneNumber: self.phoneNumber, country: self.country)
        } completion: { [weak self] result in
            guard let self = self, case let .success(code) = result else { return }
            self.verificationCode = code
            self.showEnterCodeView = true
        }
    }
    
    func signIn() {
        executeAsyncTask {
            return try await self.signInUseCase.execute(params: SignInParams(verificationCode: self.verificationCode, otpText: self.otpText))
        } completion: { [weak self] result in
            guard let self = self, case .success = result else { return }
            self.showEnterCodeView = false
            self.signInSuccess = true
        }
    }
}
