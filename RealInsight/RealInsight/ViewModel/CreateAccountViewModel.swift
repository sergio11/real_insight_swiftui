//
//  CreateAccountViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI
import Factory

class CreateAccountViewModel: BaseAuthViewModel {
    
    @Published var username = ""
    @Published var birthdate = Birthdate(day: "", month: "", year: "")
    @Published var accountFlowStep: AccountFlowStepEnum = .username
    
    @Injected(\.verifyUsernameAvailabilityUseCase) private var verifyUsernameAvailabilityUseCase: VerifyUsernameAvailabilityUseCase
    @Injected(\.sendOtpUseCase) private var sendOtpUseCase: SendOtpUseCase
    @Injected(\.signUpUseCase) private var signUpUseCase: SignUpUseCase

    func verifyUsernameAvailability() {
        executeAsyncTask {
            return try await self.verifyUsernameAvailabilityUseCase.execute(params: VerifyUsernameParams(username: self.username))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case let .success(isAvailable) = result {
                if isAvailable {
                    self.nextFlowStep()
                } else {
                    self.errorMessage = "There is already a user using this username, please use another one"
                    self.showAlert = true
                }
            }
        }
    }
    
    
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
    
    func signUp() {
        executeAsyncTask {
            return try await self.signUpUseCase.execute(params: SignUpParams(name: self.username, birthdate: self.birthdate.date, phoneNumber: self.phoneNumber, verificationCode: self.verificationCode, otpText: self.otpText))
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
