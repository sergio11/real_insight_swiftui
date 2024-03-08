//
//  SendOtpUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

struct SendOtpUseCase {
    let repository: AuthenticationRepository
    
    func execute(phoneNumber: String, country: Country) async throws -> String {
        return try await repository.signInWithPhone(phoneNumber: "+\(country.phoneCode)\(phoneNumber)")
    }
}
