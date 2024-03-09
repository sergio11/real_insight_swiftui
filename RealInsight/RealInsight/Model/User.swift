//
//  User.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/2/24.
//


struct User: Decodable, Identifiable {
    var id: String
    var fullname: String
    var birthdate: String
    var username: String?
    var profileImageUrl: String?
    var bio: String?
    var location: String?
    var phone: String
}
