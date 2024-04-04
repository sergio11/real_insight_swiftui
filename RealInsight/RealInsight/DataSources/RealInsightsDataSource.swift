//
//  RealInsightsDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

/// Enum representing errors that can occur during real insights data source operations.
enum RealInsightsDataSourceError: Error {
    /// Error indicating that a real insight could not be found.
    case realInsightNotFound(message: String)
    
    /// Error indicating that there was an issue while fetching real insights.
    case fetchFailed(message: String)
    
    /// Error indicating that there was an issue while posting a real insight.
    case postFailed(message: String)
    
    /// Error indicating that there was an issue while updating a real insight.
    case updateFailed(message: String)
    
    /// Error indicating that there was an issue while deleting a real insight.
    case deleteFailed(message: String)
}

/// Protocol defining methods for managing real insights data.
protocol RealInsightsDataSource {
    /// Fetches all real insights for the specified date asynchronously.
    /// - Parameters:
    ///   - date: The date for which to fetch real insights.
    ///   - userIds: An array of user IDs for which to fetch real insights.
    /// - Returns: An array of `RealInsightDTO` representing the fetched real insights.
    /// - Throws: An error if the operation fails, including `realInsightNotFound` if no real insights are found.
    func fetchAllRealInsights(forDate date: Date, userIds: [String]) async throws -> [RealInsightDTO]
    
    /// Fetches own real insights posted within the last specified days asynchronously.
    /// - Parameters:
    ///   - days: The number of days for which to fetch real insights.
    ///   - userId: The ID of the user whose real insights are to be fetched.
    /// - Returns: An array of `RealInsightDTO` representing the fetched real insights.
    /// - Throws: An error if the operation fails, including `realInsightNotFound` if no real insights are found.
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsightDTO]
    
    /// Posts a new real insight asynchronously.
    /// - Parameters:
    ///   - userId: The ID of the user posting the real insight.
    ///   - backImageUrl: The URL of the back image associated with the real insight.
    ///   - frontImageUrl: The URL of the front image associated with the real insight.
    /// - Returns: A `RealInsightDTO` representing the posted real insight.
    /// - Throws: An error if the operation fails.
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO
}

