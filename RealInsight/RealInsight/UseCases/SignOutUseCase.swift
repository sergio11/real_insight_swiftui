//
//  SignOutUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

struct SignOutUseCase {
    let repository: AuthenticationRepository
    
    func signOut() async throws {
        try await repository.signOut()
    }
}