//
//  CarColor.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import UIKit

typealias CarColorFilterable = FilterCellData<CarColor>

enum CarColor: String, StringIterable {
    static var name: String {return "Color"}
    
    case black = "Black"
    case gray = "Gray"
    case white = "White"
    case red = "Red"
    case yellow = "Yellow"
    case green = "Green"
    case blue = "Blue"
    case brown = "Brown"
    
}
