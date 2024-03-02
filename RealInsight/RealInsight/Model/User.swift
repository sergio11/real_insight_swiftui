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
    var fullname: String
    var date: String
    var bio: String?
    var location: String?
    var phone: String
    var isCurrentUser: Bool {
        return AuthenticationViewModel.shared.userUuid == id
    }
}
