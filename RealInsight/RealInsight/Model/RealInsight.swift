//
//  RealInsight.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI

struct RealInsight: Decodable {
    var username: String
    var frontImageUrl: String
    var userId: String
    var user: User?
}
