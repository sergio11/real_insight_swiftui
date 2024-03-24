//
//  RealInsightsDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

enum RealInsightsDataSourceError: Error {
    case realInsightNotFound
}

protocol RealInsightsDataSource {
    func fetchAllRealInsights(date: String) async throws -> [RealInsightDTO]
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsightDTO
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO
}
