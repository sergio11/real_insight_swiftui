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
    
    private let postsCollection = "posts"
    private let insightsCollection = "reals_insights"
    
    func fetchAllRealInsights(date: String) async throws -> [RealInsightDTO] {
        let db = Firestore.firestore()
        let data = try await db.collection(postsCollection)
            .document(date)
            .collection(insightsCollection)
            .getDocuments()
        return data.documents.compactMap { try? $0.data(as: RealInsightDTO.self) }
    }
        
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsightDTO {
        let db = Firestore.firestore()
        let documentSnapshot = try await db.collection(postsCollection)
            .document(date)
            .collection(insightsCollection)
            .document(userId)
            .getDocument()
        guard let insightData = try? documentSnapshot.data(as: RealInsightDTO.self) else {
            throw RealInsightsDataSourceError.realInsightNotFound
        }
        return insightData
    }
    
    func postRealInsight(userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsightDTO {
        let db = Firestore.firestore()
        do {
            let date = Date().formattedString
            let documentRef = db.collection(postsCollection)
                .document(date)
                .collection(insightsCollection)
                .document(userId)

            try await documentRef.setData([
                "frontImageUrl": frontImageUrl,
                "backImageUrl": backImageUrl,
                "userId": userId
            ])
            let realInsight = RealInsightDTO(backImageUrl: backImageUrl, frontImageUrl: frontImageUrl, userId: userId)
            return realInsight
        } catch {
            throw error
        }
    }
}
