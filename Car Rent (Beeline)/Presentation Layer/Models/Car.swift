//
//  Car.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import Foundation

struct Car {
    let name: String
    let pricePerDay: Double
    let isAvailable: Bool
    let imageUrl: String
    let rating: Double
    let overview: String
    let size: CarSize
    let color: CarColor
    let style: CarBodyStyle
    var rawValueFor: [String: String] {
        return [
            CarSize.name: size.rawValue,
            CarColor.name: color.rawValue,
            CarBodyStyle.name: style.rawValue,
        ]
    }
}
