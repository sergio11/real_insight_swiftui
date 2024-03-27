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
    @Injected(\.eventBus) internal var appEventBus: EventBus<AppEvent>
    
    func signOut() {
        executeAsyncTask({
            return try await self.signOutUseCase.execute()
        }, completion: { [weak self] result in 
            self?.appEventBus.publish(event: .loggedOut)
        })
    }
    
}
