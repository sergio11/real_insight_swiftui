//
//  RealInsightMapper.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

class RealInsightMapper: Mapper {
    typealias Input = RealInsightDataMapper
    typealias Output = RealInsight
    
    let userMapper: UserMapper
    
    init(userMapper: UserMapper) {
        self.userMapper = userMapper
    }
    
    func map(_ input: RealInsightDataMapper) -> RealInsight {
        return RealInsight(
            id: input.realInsightDTO.id,
            backImageUrl: input.realInsightDTO.backImageUrl,
            frontImageUrl: input.realInsightDTO.frontImageUrl,
            user: userMapper.map(input.userDTO),
            createdAt: input.realInsightDTO.createdAt
        )
    }
}

struct RealInsightDataMapper {
    let realInsightDTO: RealInsightDTO
    let userDTO: UserDTO
}
