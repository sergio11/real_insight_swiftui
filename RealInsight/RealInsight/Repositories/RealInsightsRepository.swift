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
    func fetchAllRealInsights(date: Date) async throws -> [RealInsight]
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsight]
    func postRealInsight(userId: String, backImageData: Data, frontImageData: Data) async throws -> RealInsight
}
