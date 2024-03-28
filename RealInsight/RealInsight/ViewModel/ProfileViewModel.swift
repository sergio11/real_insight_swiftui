//
//  ProfileViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 25/3/24.
//

import Foundation
import Factory

class ProfileViewModel: BaseUserViewModel {
    
    private let lastDays = 14
    
    @Published var ownRealInsights: [RealInsight] = []
    
    @Injected(\.fetchOwnRealInsightsUseCase) private var fetchOwnRealInsightsUseCase: FetchOwnRealInsightsUseCase
    
    func loadOwnInsights() {
        executeAsyncTask({
            return try await self.fetchOwnRealInsightsUseCase.execute(lastDays: self.lastDays)
        }, completion: { [weak self] result in
            if case .success(let realInsights) = result {
                self?.ownRealInsights = realInsights
            }
        })
    }
}
