//
//  RealInsightDTO.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

internal struct RealInsightDTO: Decodable {
    var id: String = ""
    var backImageUrl: String = ""
    var frontImageUrl: String = ""
    var userId: String = ""
    var createdAt: Date = Date()
}
