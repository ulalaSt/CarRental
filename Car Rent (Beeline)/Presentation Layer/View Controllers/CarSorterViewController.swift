//
//  ViewController.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import UIKit
import SnapKit

class CarSorterViewController: UIViewController {
        
    private var filteringOptions: [String: String] = [:]
    
    private let viewModel = CarSortingViewModel(data: Cars.allCars)
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 5
        collectionViewLayout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy private var collectionDirector: CollectionDirector = {
        let collectionDirector = CollectionDirector(collectionView: collectionView)
        return collectionDirector
    }()
    
    private let gradientView: GradientView = {
        let gradientView = GradientView(gradientColor: .link)
        return gradientView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rent Cars"
        view.backgroundColor = .orange
        layout()
        addFilters()
        bindViewModel()
        getData()
        addActions()
    }
    
    private func addFilters(){
        let filterSize = CGSize(
            width: (self.view.frame.width-10)/2,
            height: 70
        )
        collectionDirector.updateItems(with: [
            CollectionCellData(
                cellConfigurator: FilterTextCellConfigurator(data: FilterTextCellData(maxPrice: nil, minPrice: nil, name: "Price")),
                size: filterSize),
            CollectionCellData(
                cellConfigurator: FilterCellConfigurator(data: CarSizeFilterable(currentState: filteringOptions[CarSize.name])),
                size: filterSize),
            CollectionCellData(
                cellConfigurator: FilterCellConfigurator(data: CarColorFilterable(currentState: filteringOptions[CarColor.name])),
                size: filterSize),
            CollectionCellData(
                cellConfigurator: FilterCellConfigurator(data: CarBodyStyleFilterable(currentState: filteringOptions[CarBodyStyle.name])),
                size: filterSize)
        ])
    }
    
    private func layout() {
        view.addSubview(gradientView)
        gradientView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel(){
        viewModel.didLoadCars = { [weak self] cars in
            guard let strongSelf = self else {
                return
            }
            strongSelf.collectionDirector.addItems(with: cars.map { car in
                CollectionCellData(
                    cellConfigurator: CarBasicCellConfigurator(data: car),
                    size: CGSize(width: strongSelf.view.frame.width, height: 300))
            })
        }
    }
    
    private func getData(){
        viewModel.getCars()
    }
    
    private func addActions(){
        collectionDirector.actionProxy.on(action: .custom("didSelectMenuItem")) { [weak self] (configurator: FilterCellConfigurator, cell) in
            self?.filteringOptions[configurator.data.name] = cell.currentTitle
            self?.filterCollection()
        }
        collectionDirector.actionProxy.on(action: .custom("didReturnPriceRange")) { [weak self] (configurator: FilterTextCellConfigurator, cell) in
            self?.filteringOptions["MinimumPrice"] = cell.currentMin ?? nil
            self?.filteringOptions["MaximumPrice"] = cell.currentMax ?? nil
            self?.filterCollection()
        }
        collectionDirector.actionProxy.on(action: .custom("didTapDetails")) { [weak self] (configurator: CarBasicCellConfigurator, cell) in
            self?.navigationController?.pushViewController(CarDetailViewController(car: configurator.data), animated: true)
        }
    }
    
    private func filterCollection(){
        viewModel.data = Cars.allCars
        for (key, value) in filteringOptions {
            if value == "All" {
                continue
            }
            if key == "MinimumPrice" {
                guard let min = Double(value) else { continue }
                viewModel.data = viewModel.data.filter { $0.pricePerDay > min }
                
            } else if key == "MaximumPrice" {
                guard let max = Double(value) else { continue }
                viewModel.data = viewModel.data.filter { $0.pricePerDay < max }
                
            } else {
                viewModel.data = viewModel.data.filter { car in
                    if let filterValue = car.rawValueFor[key] {
                        return filterValue == value
                    } else {
                        return false
                    }
                }
            }
        }
        addFilters()
        viewModel.getCars()
    }
}

