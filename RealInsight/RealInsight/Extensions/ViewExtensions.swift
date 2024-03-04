//
//  ViewExtensions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/3/24.
//

import SwiftUI
import Combine

extension View {
    func limitText(_ upper: Int, binding: Binding<String>) -> some View {
        self.onReceive(Just(binding.wrappedValue)) { newValue in
            if newValue.count > upper {
                binding.wrappedValue = String(newValue.prefix(upper))
            }
        }
    }
    
    func filterNumericCharacters(binding: Binding<String>) -> some View {
        self.onReceive(Just(binding.wrappedValue)) { newValue in
            let filtered = newValue.filter { "0123456789".contains($0) }
            if filtered != newValue {
                binding.wrappedValue = filtered
            }
        }
    }
}
