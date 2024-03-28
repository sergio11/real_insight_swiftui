//
//  FirestoreRealInsightsDataSource.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore

internal class FirestoreRealInsightsDataSourceImpl: RealInsightsDataSource {
    
    private let insightsCollection = "reals_insights"
    
    func fetchAllRealInsights(forDate date: Date) async throws -> [RealInsightDTO] {
        let db = Firestore.firestore()
        // Convert the provided date string to a Timestamp representing the start of the day
        let startDate = date.startOfDay
        // Convert the provided date string to a Timestamp representing the end of the day
        guard let endDate = date.endOfDay else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        // Query to retrieve documents filtered by createdAt within the time range
        let data = try await db.collection(insightsCollection)
            .whereField("createdAt", isGreaterThanOrEqualTo: startDate)
            .whereField("createdAt", isLessThanOrEqualTo: endDate)
            .getDocuments()
        var insights: [RealInsightDTO] = []
        // For each document obtained in the query
        for document in data.documents {
            guard let insight = try? document.data(as: RealInsightDTO.self) else { continue }
            // Add the complete document to the list of Real Insights
            insights.append(insight)
        }
        return insights
    }
        
    func fetchOwnRealInsight(forDate date: Date, userId: String) async throws -> RealInsightDTO {
        let db = Firestore.firestore()
        // Convert the provided date string to a Timestamp representing the start of the day
        let startDate = date.startOfDay
        // Convert the provided date string to a Timestamp representing the end of the day
        guard let endDate = date.endOfDay else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        // Fetch the documents within the date range for the specified user ID
        let querySnapshot = try await db.collection(insightsCollection)
            .whereField("userId", isEqualTo: userId)
            .whereField("createdAt", isGreaterThanOrEqualTo: startDate)
            .whereField("createdAt", isLessThanOrEqualTo: endDate)
            .getDocuments()
        // Check if there are any documents returned
        guard !querySnapshot.isEmpty else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        // Get the first document (assuming there's only one for that day and user)
        let document = querySnapshot.documents[0]
        // Try to parse the document data into a RealInsightDTO object
        guard let insightData = try? document.data(as: RealInsightDTO.self) else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        
        // Return the parsed RealInsightDTO object
        return insightData
    }
    
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO {
        let db = Firestore.firestore()
        let currentDate = Date()
        let realInsightRef = try await db.collection(insightsCollection).addDocument(data: [
            "frontImageUrl": frontImageUrl,
            "backImageUrl": backImageUrl,
            "userId": userId,
            "createdAt": Timestamp(date: currentDate)
        ])
        let realInsight = RealInsightDTO(backImageUrl: backImageUrl, frontImageUrl: frontImageUrl, userId: userId)
        return realInsight
    }
}
