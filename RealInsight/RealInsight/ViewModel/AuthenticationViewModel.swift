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
    
    
    
    
    
    
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var hasSession = false
    @Published var authFlowStep: AuthFlowStepEnum = .username
    
    
    
    
    @Injected(\.signOutUseCase) private var signOutUseCase: SignOutUseCase
    
    
    
    
    
    
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
    
    

    
}


