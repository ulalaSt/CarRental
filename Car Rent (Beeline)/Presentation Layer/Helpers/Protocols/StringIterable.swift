//
//  Str.swift
//  Car Rent (Beeline)
//
//  Created by user on 19.05.2022.
//

import Foundation

protocol StringIterable: RawRepresentable & CaseIterable where RawValue == String {
    static var name: String { get }
}
