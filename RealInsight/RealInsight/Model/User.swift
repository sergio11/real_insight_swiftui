//
//  User.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/2/24.
//

struct User: Decodable, Identifiable {
    var id: String
    var username: String
    var phone: String
    var birthdate: String
    var fullname: String?
    var profileImageUrl: String?
    var bio: String?
    var location: String?
    var friendsCount: Int
}
