//
//  CarSize.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import Foundation

typealias CarSizeFilterable = FilterCellData<CarSize>

enum CarSize: String, StringIterable {
    static var name: String { return "Size" }
    
    case compact = "Compact"
    case medium = "Medium"
    case full = "Full"
}
