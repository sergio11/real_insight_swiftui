//
//  FeedViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    
    @Published var realInsightList = [RealInsight]()
    @Published var realInsight = RealInsight()
    @Published var blur = true
    
    private let user: User
    
    init(user: User) {
        self.user = user
        Task { await fetchData() }
    }
    
    func fetchData() async {
        let date = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        let dateString = formatter.string(from: date)
        if let userUuid = user.id {
            await fetchOwnPost(date: dateString, userId: userUuid)
        }
        await fetchAllRealsData(date: dateString)
    }
    
    
    private func fetchAllRealsData(date: String) async {
        let db = Firestore.firestore()
        do {
            let data = try await db.collection("posts")
                .document(date)
                .collection("reals_insights")
                .getDocuments()
            DispatchQueue.main.async { [weak self] in
                self?.realInsightList = data.documents.compactMap({ try? $0.data(as: RealInsight.self)})
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchOwnPost(date: String, userId: String) async {
        let db = Firestore.firestore()
        do {
            let data = try await db.collection("posts").document(date).collection("reals_insights")
                .document(userId)
                .getDocument()
            DispatchQueue.main.async { [weak self] in
                if let realInsight = try? data.data(as: RealInsight.self) {
                    self?.realInsight = realInsight
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
