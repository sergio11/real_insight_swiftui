//
//  UserDTO.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

internal struct UserDTO: Decodable {
    var userId: String
    var username: String
    var birthdate: String
    var phoneNumber: String
    var fullname: String?
    var location: String?
    var bio: String?
    var profileImageUrl: String?
    var friends: [String]
    var followerRequests: [String]
    var followingRequests: [String]
}
