//
//  SuggestionsViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation
import SwiftUI
import Factory

class SuggestionsViewModel: BaseViewModel {
    
    @Published var suggestions: [User] = []
    
    @Injected(\.getSuggestionsUseCase) private var getSuggestionsUseCase: GetSuggestionsUseCase
    
    func loadSuggestions() {
        executeAsyncTask({
            return try await self.getSuggestionsUseCase.execute()
        }, completion: { [weak self] result in
            if case .success(let suggestions) = result {
                self?.suggestions = suggestions
            }
        })
    }
}
