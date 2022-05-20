//
//  CarRentingViewController.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import UIKit

class CarRentingViewController: UIViewController {
    
    private let viewModel = CarRentingViewModel()
    
    init(car: Car){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
    }
}
