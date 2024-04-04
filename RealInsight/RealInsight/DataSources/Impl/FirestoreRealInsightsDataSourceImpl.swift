//
//  FirestoreRealInsightsDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A data source responsible for managing real insights data using Firestore.
internal class FirestoreRealInsightsDataSourceImpl: RealInsightsDataSource {
    
    /// The name of the Firestore collection containing real insights data.
    private let insightsCollection = "reals_insights"
    
    /// Fetches all real insights for a given date asynchronously.
    /// - Parameters:
    ///   - date: The date for which real insights are to be fetched.
    /// - Returns: An array of `RealInsightDTO` objects representing the fetched real insights.
    /// - Throws: An `RealInsightsDataSourceError` in case of failure, including `realInsightNotFound` if no real insights are found.
    func fetchAllRealInsights(forDate date: Date, userIds: [String]) async throws -> [RealInsightDTO] {
        let db = Firestore.firestore()
        let startDate = date.startOfDay
        guard let endDate = date.endOfDay else {
            throw RealInsightsDataSourceError.realInsightNotFound(message: "End of day not found.")
        }
        do {
            let data = try await db.collection(insightsCollection)
                .whereField("createdAt", isGreaterThanOrEqualTo: startDate)
                .whereField("createdAt", isLessThanOrEqualTo: endDate)
                .whereField("userId", in: userIds)
                .getDocuments()
            var insights: [RealInsightDTO] = []
            for document in data.documents {
                guard let insight = try? document.data(as: RealInsightDTO.self) else {
                    throw RealInsightsDataSourceError.fetchFailed(message: "Failed to parse real insight data.")
                }
                insights.append(insight)
            }
            return insights
        } catch let error as RealInsightsDataSourceError {
            throw error
        } catch {
            throw RealInsightsDataSourceError.fetchFailed(message: error.localizedDescription)
        }
    }
        
    /// Fetches real insights posted by a specific user within the last specified days asynchronously.
    /// - Parameters:
    ///   - lastDays: The number of days to consider for fetching real insights.
    ///   - userId: The ID of the user for whom real insights are to be fetched.
    /// - Returns: An array of `RealInsightDTO` objects representing the fetched real insights.
    /// - Throws: An `RealInsightsDataSourceError` in case of failure, including `realInsightNotFound` if no real insights are found.
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsightDTO] {
        let db = Firestore.firestore()
        let currentDate = Date()
        guard let startDate = Calendar.current.date(byAdding: .day, value: -days, to: currentDate) else {
            throw RealInsightsDataSourceError.realInsightNotFound(message: "Start date not found.")
        }
        do {
            let querySnapshot = try await db.collection(insightsCollection)
                .whereField("userId", isEqualTo: userId)
                .whereField("createdAt", isGreaterThanOrEqualTo: startDate)
                .getDocuments()
            guard !querySnapshot.isEmpty else {
                throw RealInsightsDataSourceError.realInsightNotFound(message: "No real insights found.")
            }
            var insights: [RealInsightDTO] = []
            for document in querySnapshot.documents {
                guard let insightData = try? document.data(as: RealInsightDTO.self) else {
                    throw RealInsightsDataSourceError.fetchFailed(message: "Failed to parse real insight data.")
                }
                insights.append(insightData)
            }
            return insights
        } catch let error as RealInsightsDataSourceError {
            throw error
        } catch {
            throw RealInsightsDataSourceError.fetchFailed(message: error.localizedDescription)
        }
    }
    
    /// Posts a new real insight asynchronously.
    /// - Parameters:
    ///   - userId: The ID of the user posting the real insight.
    ///   - backImageUrl: The URL of the back image of the real insight.
    ///   - frontImageUrl: The URL of the front image of the real insight.
    /// - Returns: A `RealInsightDTO` object representing the posted real insight.
    /// - Throws: An `RealInsightsDataSourceError` in case of failure, including `postFailed` if the real insight posting fails.
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO {
        let db = Firestore.firestore()
        let currentDate = Date()
        let uuid = UUID()
        let uuidString = uuid.uuidString
        do {
            try await db.collection(insightsCollection).addDocument(data: [
                "id": uuidString,
                "frontImageUrl": frontImageUrl,
                "backImageUrl": backImageUrl,
                "userId": userId,
                "createdAt": Timestamp(date: currentDate)
            ])
            let realInsight = RealInsightDTO(id: uuidString, backImageUrl: backImageUrl, frontImageUrl: frontImageUrl, userId: userId)
            return realInsight
        } catch {
            throw RealInsightsDataSourceError.postFailed(message: error.localizedDescription)
        }
    }
}

