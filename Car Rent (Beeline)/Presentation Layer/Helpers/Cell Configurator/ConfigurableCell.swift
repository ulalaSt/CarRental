//
//  ConfigurableCell.swift
//  One-Lab-5
//
//  Created by user on 24.04.2022.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
