//
//  UserMapper.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

class UserMapper: Mapper {
    typealias Input = UserDTO
    typealias Output = User
    
    func map(_ input: UserDTO) -> User {
        return User(
            id: input.userId,
            fullname: input.fullname,
            birthdate: input.date,
            username: input.username,
            profileImageUrl: input.profileImageUrl,
            bio: input.bio,
            location: input.location,
            phone: input.phone
        )
    }
}
