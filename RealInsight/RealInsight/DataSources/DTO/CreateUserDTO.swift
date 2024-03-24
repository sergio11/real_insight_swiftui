//
//  CreateUserDTO.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 24/3/24.
//

import Foundation

internal struct CreateUserDTO: Decodable {
    var userId: String
    var username: String
    var birthdate: String
    var phoneNumber: String
}
