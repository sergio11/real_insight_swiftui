//
//  SendOtpUseCase.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

/// An entity responsible for sending OTP (One-Time Password).
struct SendOtpUseCase {
    let repository: AuthenticationRepository
    
    /// Executes the OTP sending operation asynchronously.
        /// - Parameters:
        ///   - phoneNumber: The phone number to which the OTP will be sent.
        ///   - country: The country for which the OTP is being sent.
        /// - Returns: A string representing the result of the OTP sending operation.
        /// - Throws: An error if the OTP sending operation fails.
    func execute(phoneNumber: String, country: Country) async throws -> String {
        return try await repository.signInWithPhone(phoneNumber: "+\(country.phoneCode)\(phoneNumber)")
    }
}
