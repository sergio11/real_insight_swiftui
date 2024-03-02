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
    
    init() {
        let date = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        let dateString = formatter.string(from: date)
        Task {
            await fetchData(date: dateString)
        }
    }
    
    func fetchData(date: String) async {
        let db = Firestore.firestore()
        do {
            let data = try await db.collection("posts")
                .document(date)
                .collection("reals_insights")
                .getDocuments()
            self.realInsightList = data.documents.compactMap({ try? $0.data(as: RealInsight.self)})
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
