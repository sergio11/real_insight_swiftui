//
//  SaveUserDTO.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

internal struct SaveUserDTO: Decodable {
    var userId: String
    var fullname: String
    var username: String?
    var location: String?
    var bio: String?
    var profileImageUrl: String?
}
