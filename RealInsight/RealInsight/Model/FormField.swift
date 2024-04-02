//
//  FormField.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 2/4/24.
//

import Foundation

protocol FormField {
    var key: String { get }
    var label: String { get }
    var placeholder: String { get }
    
    func getValue<T>() -> T?
    mutating func setValue<T>(_ newValue: T?)
}

struct TextFormField: FormField {
    
    let key: String
    let label: String
    let placeholder: String
    var value: String
    
    func getValue<T>() -> T? {
        return value as? T
    }
    
    mutating func setValue<T>(_ newValue: T?) {
        if let newValue = newValue as? String {
            self.value = newValue
        }
    }
}

struct TextAreaFormField: FormField {
    let key: String
    let label: String
    let placeholder: String
    var value: String
    
    func getValue<T>() -> T? {
        return value as? T
    }
    
    mutating func setValue<T>(_ newValue: T?) {
        if let newValue = newValue as? String {
            self.value = newValue
        }
    }
}

struct DatePickerFormField: FormField {
    let key: String
    let label: String
    let placeholder: String
    var value: Date
    
    func getValue<T>() -> T? {
        return value as? T
    }
    
    mutating func setValue<T>(_ newValue: T?) {
        if let newValue = newValue as? Date {
            self.value = newValue
        }
    }
}
