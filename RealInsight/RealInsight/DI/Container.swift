//
//  Container.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory


extension Container {
    
    var realInsightsRepository: Factory<RealInsightsRepository> {
        self { FirestoreRealInsightsRepository() }.singleton
    }
    
    var fetchRealInsightsUseCase: Factory<FetchRealInsightsUseCase> {
        self { FetchRealInsightsUseCase(repository: self.realInsightsRepository()) }
    }
}
