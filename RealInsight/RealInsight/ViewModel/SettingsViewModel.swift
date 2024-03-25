//
//  SettingsViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 25/3/24.
//

import Foundation
import Factory

class SettingsViewModel: BaseUserViewModel {
    
    @Injected(\.signOutUseCase) private var signOutUseCase: SignOutUseCase
    
    func signOut() {
        executeAsyncTask({
            return try await self.signOutUseCase.execute()
        }, completion: { result in
            
        })
    }
    
}
