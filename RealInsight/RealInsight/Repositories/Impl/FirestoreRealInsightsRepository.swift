//
//  FirestoreRealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Firebase

internal class FirestoreRealInsightsRepository: RealInsightsRepository {
    
    private let postsCollection = "posts"
    private let insightsCollection = "reals_insights"
    
    func fetchAllRealInsights(date: String) async throws -> [RealInsight] {
        let db = Firestore.firestore()
        let data = try await db.collection(postsCollection)
            .document(date)
            .collection(insightsCollection)
            .getDocuments()
        return data.documents.compactMap { try? $0.data(as: RealInsight.self) }
    }
        
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsight? {
        let db = Firestore.firestore()
        let data = try await db.collection(postsCollection)
            .document(date)
            .collection(insightsCollection)
            .document(userId)
            .getDocument()
        return try data.data(as: RealInsight.self)
    }
}
