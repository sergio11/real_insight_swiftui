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
        
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsightDTO] {
        let db = Firestore.firestore()
        // Get the current date
        let currentDate = Date()
        // Calculate the start date by subtracting the specified days
        guard let startDate = Calendar.current.date(byAdding: .day, value: -days, to: currentDate) else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        // Create a query for documents for the user and within the date range
        let querySnapshot = try await db.collection(insightsCollection)
            .whereField("userId", isEqualTo: userId)
            .whereField("createdAt", isGreaterThanOrEqualTo: startDate)
            .getDocuments()
        
        // Check if there are any returned documents
        guard !querySnapshot.isEmpty else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        // Create a list to store RealInsightDTO objects
        var insights: [RealInsightDTO] = []
        // Iterate over each document and convert it into a RealInsightDTO object
        for document in querySnapshot.documents {
            guard let insightData = try? document.data(as: RealInsightDTO.self) else {
                throw RealInsightsDataSourceError.realInsightNotFound
            }
            insights.append(insightData)
        }
        // Return the list of converted RealInsightDTO objects
        return insights
    }
    
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO {
        let db = Firestore.firestore()
        let currentDate = Date()
        let uuid = UUID()
        let uuidString = uuid.uuidString
        try await db.collection(insightsCollection).addDocument(data: [
            "id": uuidString,
            "frontImageUrl": frontImageUrl,
            "backImageUrl": backImageUrl,
            "userId": userId,
            "createdAt": Timestamp(date: currentDate)
        ])
        let realInsight = RealInsightDTO(id: uuidString, backImageUrl: backImageUrl, frontImageUrl: frontImageUrl, userId: userId)
        return realInsight
    }
}
