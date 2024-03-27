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
    
    func verifySession() {
        executeAsyncTask({
            return try await self.verifySessionUseCase.execute()
        }) { [weak self] (result: Result<Bool, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let hasSession):
                if hasSession {
                    self.onActiveSessionFound()
                } else {
                    self.onNotActiveSessionFound()
                }
            case .failure:
                self.onNotActiveSessionFound()
            }
        }
    }

    private func onNotActiveSessionFound() {
        self.isLoading = false
        self.hasSession = false
    }

    private func onActiveSessionFound() {
        self.isLoading = false
        self.hasSession = true
    }
}
