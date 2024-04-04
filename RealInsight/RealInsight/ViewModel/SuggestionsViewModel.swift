//
//  SuggestionsViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation
import SwiftUI
import Factory

class SuggestionsViewModel: BaseUserViewModel {
    
    @Published var suggestions: [User] = []
    
    @Injected(\.getSuggestionsUseCase) private var getSuggestionsUseCase: GetSuggestionsUseCase
    @Injected(\.createFriendsRequestUseCase) private var createFriendsRequestUseCase: CreateFriendsRequestUseCase
    
    func loadSuggestions() {
        executeAsyncTask({
            return try await self.getSuggestionsUseCase.execute()
        }, completion: { [weak self] result in
            if case .success(let suggestions) = result {
                self?.suggestions = suggestions
            }
        })
    }
    
    func createFriendRequest(toUserId: String) {
        executeAsyncTask({
            return try await self.createFriendsRequestUseCase.execute(params: CreateFriendsRequestParams(toUserId: toUserId))
        }, completion: { [weak self] result in
            self?.removeUserById(userId: toUserId)
        })
    }
    
    func discardSuggestion(toUserId: String) {
        removeUserById(userId: toUserId)
    }
    
    private func removeUserById(userId: String) {
        if let userIdx = suggestions.firstIndex(where: { $0.id == userId}) {
            suggestions.remove(at: userIdx)
        }
    }
}
