//
//  Year.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/2/24.
//

import Foundation
import SwiftUI

public struct Birthdate {
    public var day: String
    public var month: String
    public var year: String
    
    public init(day: String, month: String, year: String) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    var date: String {
        return "\(day)/\(month)/\(year)"
    }
}
