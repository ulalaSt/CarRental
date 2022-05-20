//
//  ViewModel.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import Foundation
import UIKit

class CarSortingViewModel {    
    var data: [Car]
    
    init(data: [Car]){
        self.data = data
    }
    
    var didLoadCars: (([Car]) -> Void)?
    
    func getCars(){
        didLoadCars?(data)
    }
}
