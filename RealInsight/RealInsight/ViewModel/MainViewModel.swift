//
//  MainViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI
import Factory

class MainViewModel: BaseViewModel {
    
    @Published var hasSession = false
    
    @Injected(\.verifySessionUseCase) private var verifySessionUseCase: VerifySessionUseCase
    
    func verifySession() async {
        onLoading()
        do {
            if let userId = try await verifySessionUseCase.verifySession() {
                onActiveSessionFound(userId: userId)
            } else {
                onNotActiveSessionFound()
            }
        } catch {
            onNotActiveSessionFound()
        }
    }

    private func onNotActiveSessionFound() {
        updateUI { (vm: MainViewModel) in
            vm.isLoading = false
            vm.hasSession = false
        }
    }

    private func onActiveSessionFound(userId: String) {
        updateUI { (vm: MainViewModel) in
            vm.isLoading = false
            vm.hasSession = true
        }
    }
}
