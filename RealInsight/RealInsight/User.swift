//
//  User.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/2/24.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Decodable, Identifiable {
    @DocumentID var id: String?
    var username: String?
    var profileImageUrl: String?
    var name: String
    var date: String
    var bio: String?
    var location: String?
}
