//
//  BaseViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

class BaseViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    internal func onLoading() {
        updateUI { vm in
            vm.isLoading = true
        }
    }
    
    internal func handleError(error: Error) {
        print(error.localizedDescription)
        updateUI { vm in
            vm.isLoading = false
            vm.errorMessage = error.localizedDescription
            vm.showAlert.toggle()
        }
    }
    
    
    internal func updateUI<ViewModelType: BaseViewModel>(with updates: @escaping (ViewModelType) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let viewModel = self as? ViewModelType {
                updates(viewModel)
            }
        }
    }
}
