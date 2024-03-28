//
//  ArrayExtensions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/3/24.
//

import Foundation

extension Array {
    func chunkedBy(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map { startIndex in
            let endIndex = Swift.min(startIndex + size, count)
            return Array(self[startIndex..<endIndex])
        }
    }
}
