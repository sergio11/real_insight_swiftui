//
//  FeedCellViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    
    private var realInsight: RealInsight
    
    var authorProfileImageUrl: String {
        get { realInsight.user.profileImageUrl ?? "" }
    }
    
    var authorUsername: String {
        get { realInsight.user.username }
    }
    
    var authorFullname: String {
        get { realInsight.user.fullname ?? authorUsername}
    }
    
    var realInsightBackImageUrl: String {
        get { realInsight.backImageUrl }
    }
    
    var realInsightFrontImageUrl: String {
        get { realInsight.frontImageUrl }
    }
    
    init(realInsight: RealInsight) {
        self.realInsight = realInsight
    }
}
