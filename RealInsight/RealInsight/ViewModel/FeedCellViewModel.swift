//
//  FeedCellViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    
    @Published var realInsight: RealInsight
    
    init(realInsight: RealInsight) {
        self.realInsight = realInsight
        fetchRealInsightUser()
    }
    
    func fetchRealInsightUser() {
        Firestore.firestore().collection("users")
            .document(realInsight.userId).getDocument { sp, err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                self.realInsight.user = try? sp?.data(as: User.self)
            }
    }
    
}
