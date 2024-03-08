//
//  FeedViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/3/24.
//

import SwiftUI
import Factory

class FeedViewModel: ObservableObject {
    
    @Published var realInsightList = [RealInsight]()
    @Published var realInsight: RealInsight = RealInsight()
    @Published var blur = true
    
    @Injected(\.fetchRealInsightsUseCase) private var fetchRealInsightsUseCase: FetchRealInsightsUseCase
    
    init() {
        Task { await fetchData() }
    }
    
    func fetchData() async {
        do {
            let (allRealInsights, ownRealInsight) = try await fetchRealInsightsUseCase.execute(date: Date.now.formattedString)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.realInsightList = allRealInsights
                if let realInsight = ownRealInsight {
                    self.realInsight = realInsight
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
