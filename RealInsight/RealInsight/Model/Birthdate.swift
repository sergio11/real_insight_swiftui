//
//  Year.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/2/24.
//

import Foundation
import SwiftUI

public struct Birthdate: Equatable {
    public var day: String
    public var month: String
    public var year: String
    
    public init(day: String, month: String, year: String) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    func hasDataValid() -> Bool {
        return !day.isEmpty && !month.isEmpty && !year.isEmpty
    }
    
    var date: String {
        return "\(day)/\(month)/\(year)"
    }
}
