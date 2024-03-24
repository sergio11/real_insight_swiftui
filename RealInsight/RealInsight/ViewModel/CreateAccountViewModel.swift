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

    func sendOtp() async {
        print("sendOtp isLoading: \(isLoading) CALLED!")
        guard !isLoading else { return }
        do {
            onLoading()
            let result = try await sendOtpUseCase.execute(phoneNumber: phoneNumber, country: country)
            print("sendOtp result \(result) CALLED!")
            updateUI { (vm: CreateAccountViewModel) in
                vm.isLoading = false
                vm.verificationCode = result
                vm.nextFlowStep()
            }
        } catch {
            print("sendOtp handleError \(error.localizedDescription) CALLED!")
            handleError(error: error)
        }
    }
    
    func verifyOtp() async {
        do {
            onLoading()
            let user = try await signUpUseCase.execute(params: SignUpParams(name: name, birthdate: birthdate.date, phoneNumber: phoneNumber, verificationCode: verificationCode, otpText: otpText))
            updateUI { (vm: CreateAccountViewModel) in
                vm.isLoading = false
                vm.nextFlowStep()
            }
        }
        catch {
            print("ERROR")
            handleError(error: error)
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
