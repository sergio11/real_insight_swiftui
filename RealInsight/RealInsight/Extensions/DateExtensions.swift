//
//  DateExtensions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/3/24.
//

import Foundation

extension Date {
    
    func formattedString(withFormat format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)
    }
    
    func dayOfMonth() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        return "\(day)"
    }
    
    func hoursLate() -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let hours = calendar.dateComponents([.hour], from: self, to: currentDate).hour ?? 0
        return max(0, hours)
    }
}
