//
//  UpdateUserDTO+Dictionary.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 24/3/24.
//

import Foundation

internal extension UpdateUserDTO {
    func asDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "userId": userId,
            "fullname": fullname
        ]

        if let username = username {
            dictionary["username"] = username
        }
        if let location = location {
            dictionary["location"] = location
        }
        if let bio = bio {
            dictionary["bio"] = bio
        }
        if let profileImageUrl = profileImageUrl {
            dictionary["profileImageUrl"] = profileImageUrl
        }

        return dictionary
    }
}
