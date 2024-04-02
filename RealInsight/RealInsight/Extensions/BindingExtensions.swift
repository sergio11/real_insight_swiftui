//
//  BindingExtensions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/4/24.
//

import Foundation
import SwiftUI

extension Binding {
    static func create<T>(_ value: inout T) -> Binding<T> {
        Binding<T>(
            get: { value },
            set: { newValue in value = newValue }
        )
    }
}
