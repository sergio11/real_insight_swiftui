//
//  StringExtensions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 29/3/24.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
