//
//  CreateUserDTO+Dictionary.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 24/3/24.
//

import Foundation

internal extension CreateUserDTO {
    func asDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "username": username,
            "birthdate": birthdate,
            "phoneNumber": phoneNumber
        ]
    }
}
