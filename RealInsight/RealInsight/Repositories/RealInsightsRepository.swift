//
//  RealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import UIKit

enum RealInsightsRepositoryError: Error {
    case postFailed
    case realInsightNotFound
}

protocol RealInsightsRepository {
    func fetchAllRealInsights(date: String) async throws -> [RealInsight]
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsight
    func postRealInsight(date: String, userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsight
}
