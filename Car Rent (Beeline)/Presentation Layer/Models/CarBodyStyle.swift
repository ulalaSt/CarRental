//
//  File.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import Foundation

typealias CarBodyStyleFilterable = FilterCellData<CarBodyStyle>

enum CarBodyStyle: String, StringIterable {
    
    static var name: String { "Style" }
    
    case sedan = "Sedan"
    case hatchback = "Hatchback"
    case coupe = "Coupe"
    case sportsCar = "Sports Car"
    case convertible = "Convertible"
    case minivan = "Minivan"
    case suv = "SUV"
    
    var description : String {
        switch self {
        case .sedan:
            return "A sedan has four doors and a traditional trunk. Like vehicles in many categories, they're available in a range of sizes from small to full-size."
        case .hatchback:
            return "Traditionally, the term \"hatchback\" has meant a compact or subcompact sedan with a squared-off roof and a rear flip-up hatch door that provides access to the vehicle's cargo area instead of a conventional trunk."
        case .coupe:
            return "A coupe has historically been considered a two-door car with a trunk and a solid roof."
        case .sportsCar:
            return "These are the sportiest, hottest, coolest-looking coupes and convertibles—low to the ground, sleek, and often expensive."
        case .convertible:
            return "Does the roof retract into the body leaving the passenger cabin open to the elements? If so, it's a convertible."
        case .minivan:
            return "Minivans are the workhorses of the family-car world, the best at carrying people and cargo in an efficient package."
        case .suv:
            return "SUV or SPORT-UTILITY VEHICLE — often also referred to as crossovers—tend to be taller and boxier than sedans, offer an elevated seating position, and have more ground clearance than a car."
        }
    }
}
