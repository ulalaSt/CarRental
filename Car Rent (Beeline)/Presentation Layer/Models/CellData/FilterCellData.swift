//
//  FilterCellData.swift
//  Car Rent (Beeline)
//
//  Created by user on 19.05.2022.
//

import Foundation

class FilterCellData<T: StringIterable>: FilterData {
    var name: String {
        return T.name
    }
    
    var selectionRange: [String] {
        return T.allCases.map { $0.rawValue }
    }
    
    var currentState: String?
    
    var enumSelf = T.self
    
    init(currentState: String?){
        self.currentState = currentState
    }
}

protocol FilterData {
    var name: String { get }
    var selectionRange: [String] { get }
    var currentState: String? { get }
}
