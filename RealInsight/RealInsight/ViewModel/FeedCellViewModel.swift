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
    }
    
}
