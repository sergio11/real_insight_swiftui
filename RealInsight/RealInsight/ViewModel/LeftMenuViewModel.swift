//
//  LeftMenuViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/3/24.
//

import Foundation

class LeftMenuViewModel: BaseViewModel {
    
    @Published var tabs = ["Suggestions", "Friends", "Requests"]
    @Published var tabSelected: String = "Suggestions"
    
}
