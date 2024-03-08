//
//  AuthenticationViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/2/24.
//

import SwiftUI
import Firebase
import Factory

class AuthenticationViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var birthdate = Birthdate(day: "", month: "", year: "")
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    @Published var otpText = ""
    @Published var verificationCode: String = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var hasSession = false
    @Published var authFlowStep: AuthFlowStepEnum = .username
    
    
    @Injected(\.sendOtpUseCase) private var sendOtpUseCase: SendOtpUseCase
    @Injected(\.verifyOtpUseCase) private var verifyOtpUseCase: VerifyOtpUseCase
    @Injected(\.signOutUseCase) private var signOutUseCase: SignOutUseCase
    @Injected(\.verifySessionUseCase) private var verifySessionUseCase: VerifySessionUseCase
    
    
    var userUuid: String {
        guard let user = currentUser else { return "" }
        return user.id ?? ""
    }
    
    var username: String {
        guard let user = currentUser else { return "" }
        return user.username ?? user.fullname.lowercased()
    }
    
    var fullName: String {
        guard let user = currentUser else { return "" }
        return user.fullname
    }
    
    func sendOtp() async {
        print("sendOtp isLoading: \(isLoading) CALLED!")
        guard !isLoading else { return }
        do {
            onLoading()
            let result = try await sendOtpUseCase.execute(phoneNumber: phoneNumber, country: country)
            print("sendOtp result \(result) CALLED!")
            updateUI { vm in
                vm.isLoading = false
                vm.verificationCode = result
                vm.nextAuthFlowStep()
            }
        } catch {
            print("sendOtp handleError \(error.localizedDescription) CALLED!")
            handleError(error: error)
        }
    }
    
    func verifyOtp() async {
        do {
            onLoading()
            let user = try await verifyOtpUseCase.execute(verificationCode: verificationCode, otpText: otpText)
            updateUI { vm in
                vm.isLoading = false
                vm.currentUser = User(fullname: vm.name, date: vm.birthdate.date, phone: "+\(vm.country.phoneCode)\(vm.phoneNumber)")
                vm.hasSession = true
            }
        }
        catch {
            print("ERROR")
            handleError(error: error)
        }
    }
    
    func signOut() async {
        do {
            try await signOutUseCase.signOut()
            updateUI { vm in
                vm.isLoading = false
                vm.authFlowStep = .username
                vm.hasSession = false
            }
        } catch {
            print("signOut error")
            handleError(error: error)
        }
    }
    
    func verifySession() async {
        onLoading()
        do {
            if let user = try await verifySessionUseCase.verifySession() {
                onActiveSessionFound(user: user)
            } else {
                onNotActiveSessionFound()
            }
        } catch {
            onNotActiveSessionFound()
        }
    }
 
    func nextAuthFlowStep() {
        switch authFlowStep {
        case .username:
            authFlowStep = .birthdate
        case .birthdate:
            authFlowStep = .phoneNumber
        case .phoneNumber:
            authFlowStep = .otp
        case .otp:
            authFlowStep = .completed
        case .completed:
            break
        }
    }
    
    func previousAuthFlowStep() {
        switch authFlowStep {
        case .username:
            break
        case .birthdate:
            authFlowStep = .username
        case .phoneNumber:
            authFlowStep = .birthdate
        case .otp:
            authFlowStep = .phoneNumber
        case .completed:
            authFlowStep = .otp
        }
    }
    

    private func onLoading() {
        updateUI { vm in
            vm.isLoading = true
        }
    }

    private func onNotActiveSessionFound() {
        updateUI { vm in
            vm.isLoading = false
            vm.hasSession = false
        }
    }

    private func onActiveSessionFound(user: User) {
        updateUI { vm in
            vm.isLoading = false
            vm.hasSession = true
            vm.currentUser = user
        }
    }

    private func handleError(error: Error) {
        print(error.localizedDescription)
        updateUI { vm in
            vm.isLoading = false
            vm.errorMessage = error.localizedDescription
            vm.showAlert.toggle()
        }
    }
    
    private func updateUI(with updates: @escaping (AuthenticationViewModel) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            updates(self)
        }
    }
}

enum AuthFlowStepEnum {
    case username
    case birthdate
    case phoneNumber
    case otp
    case completed
}
