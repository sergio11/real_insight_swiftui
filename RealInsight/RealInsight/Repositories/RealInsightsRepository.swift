//
//  RealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation

/// Enum representing errors that can occur during real insights repository operations.
enum RealInsightsRepositoryError: Error {
    /// Error indicating that posting a real insight failed.
    case postFailed
    /// Error indicating that a real insight could not be found.
    case realInsightNotFound
}

/// A repository responsible for managing real insights data.
protocol RealInsightsRepository {
    /// Fetches all real insights for the specified date and user ID asynchronously.
    /// - Parameters:
    ///   - date: The date for which to fetch real insights.
    ///   - userId: The ID of the user for which to fetch real insights.
    /// - Returns: An array of `RealInsight` representing the fetched real insights.
    /// - Throws: An error if the operation fails, including `realInsightNotFound` if no real insights are found.
    func fetchAllRealInsights(date: Date, userId: String) async throws -> [RealInsight]
    
    /// Fetches own real insights for the specified user and last number of days asynchronously.
    /// - Parameters:
    ///   - days: The number of past days from which to fetch real insights.
    ///   - userId: The ID of the user for which to fetch real insights.
    /// - Returns: An array of `RealInsight` representing the fetched real insights.
    /// - Throws: An error if the operation fails, including `realInsightNotFound` if no real insights are found.
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsight]
    
    /// Posts a new real insight asynchronously.
    /// - Parameters:
    ///   - userId: The ID of the user posting the real insight.
    ///   - backImageData: The data of the image taken from the back camera.
    ///   - frontImageData: The data of the image taken from the front camera.
    /// - Returns: A `RealInsight` object representing the posted real insight.
    /// - Throws: An error if the operation fails, including `postFailed` if posting the real insight fails.
    func postRealInsight(userId: String, backImageData: Data, frontImageData: Data) async throws -> RealInsight
}
