//
//  FormFieldExtensions.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/4/24.
//

import Foundation

extension FormField {
    func getValue<T>() -> T? {
        return nil
    }
}

extension Array where Element == FormField {
    func value(for key: String) -> String {
        return self.first(where: { $0.key == key })?.getValue() ?? ""
    }
}
