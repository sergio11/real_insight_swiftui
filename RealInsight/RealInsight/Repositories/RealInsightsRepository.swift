//
//  RealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

protocol RealInsightsRepository {
    func fetchAllRealInsights(date: String) async throws -> [RealInsight]
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsight?
}
