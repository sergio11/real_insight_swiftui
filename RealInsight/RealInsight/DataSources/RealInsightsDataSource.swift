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
    func fetchAllRealInsights(forDate date: Date) async throws -> [RealInsightDTO]
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsightDTO]
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO
}
