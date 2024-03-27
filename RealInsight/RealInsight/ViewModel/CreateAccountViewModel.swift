//
//  CreateAccountViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI
import Factory

class CreateAccountViewModel: BaseViewModel {
    
    @Published var name = ""
    @Published var otpText = ""
    @Published var birthdate = Birthdate(day: "", month: "", year: "")
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    @Published var accountFlowStep: AccountFlowStepEnum = .username
    
    @Injected(\.sendOtpUseCase) private var sendOtpUseCase: SendOtpUseCase
    @Injected(\.signUpUseCase) private var signUpUseCase: SignUpUseCase
    
    private var verificationCode: String = ""

    func sendOtp() {
        guard !isLoading else { return }
        executeAsyncTask {
            return try await self.sendOtpUseCase.execute(phoneNumber: self.phoneNumber, country: self.country)
        } completion: { [weak self] result in
            guard let self = self, case let .success(code) = result else { return }
            self.verificationCode = code
            self.nextFlowStep()
        }
    }
    
    func verifyOtp() {
        executeAsyncTask {
            return try await self.signUpUseCase.execute(params: SignUpParams(name: self.name, birthdate: self.birthdate.date, phoneNumber: self.phoneNumber, verificationCode: self.verificationCode, otpText: self.otpText))
        } completion: { [weak self] result in
            guard let self = self, case .success = result else { return }
            self.nextFlowStep()
        }
    }
    
    
    func nextFlowStep() {
        switch accountFlowStep {
        case .username:
            accountFlowStep = .birthdate
        case .birthdate:
            accountFlowStep = .phoneNumber
        case .phoneNumber:
            accountFlowStep = .otp
        case .otp:
            accountFlowStep = .completed
        case .completed:
            break
        }
    }
    
    func previousFlowStep() {
        switch accountFlowStep {
        case .username:
            break
        case .birthdate:
            accountFlowStep = .username
        case .phoneNumber:
            accountFlowStep = .birthdate
        case .otp:
            accountFlowStep = .phoneNumber
        case .completed:
            accountFlowStep = .otp
        }
    }
    
}

enum AccountFlowStepEnum {
    case username
    case birthdate
    case phoneNumber
    case otp
    case completed
}
