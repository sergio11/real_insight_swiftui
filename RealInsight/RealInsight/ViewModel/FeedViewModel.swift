//
//  FeedViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI
import Factory

class FeedViewModel: BaseUserViewModel {
    
    @Published var realInsightList = [RealInsight]()
    @Published var backImageUrl: String = ""
    @Published var frontImageUrl: String = ""
    @Published var hasOwnRealInsightPublished = false
    @Published var cameraViewPressented: Bool = false
    
    @Injected(\.fetchRealInsightsUseCase) private var fetchRealInsightsUseCase: FetchRealInsightsUseCase
    
    func fetchData() {
        executeAsyncTask {
            return try await self.fetchRealInsightsUseCase.execute(date: Date.now)
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let (allRealInsights, ownRealInsight)) = result {
                self.realInsightList = allRealInsights
                if let realInsight = ownRealInsight {
                    self.backImageUrl = realInsight.backImageUrl
                    self.frontImageUrl = realInsight.frontImageUrl
                    self.hasOwnRealInsightPublished = true
                }
            }
        }
    }
}
