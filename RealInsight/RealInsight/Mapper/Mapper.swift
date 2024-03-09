//
//  Mapper.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    func map(_ input: Input) -> Output
}
