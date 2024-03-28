//
//  RealInsight.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI

struct RealInsight: Decodable, Identifiable, Hashable, Equatable {
    
    var id: String
    var backImageUrl: String
    var frontImageUrl: String
    var user: User
    var createdAt: Date
    
    static func == (lhs: RealInsight, rhs: RealInsight) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
