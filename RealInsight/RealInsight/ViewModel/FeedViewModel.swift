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
    @Published var realInsight: RealInsight?
    @Published var blur = true
    
    private let user: User
    private let fetchRealInsightsUseCase: FetchRealInsightsUseCase
    
    init(user: User, fetchRealInsightsUseCase: FetchRealInsightsUseCase) {
        self.user = user
        self.fetchRealInsightsUseCase = fetchRealInsightsUseCase
        Task { await fetchData() }
    }
    
    func fetchData() async {
        do {
            let (allRealInsights, ownRealInsight) = try await fetchRealInsightsUseCase.execute(date: Date.now.formattedString, userId: user.id)
            DispatchQueue.main.async { [weak self] in
                self?.realInsightList = allRealInsights
                self?.realInsight = ownRealInsight
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
