//
//  CarDetailViewController.swift
//  Car Rent (Beeline)
//
//  Created by user on 19.05.2022.
//

import UIKit
import SnapKit

class CarDetailViewController: UIViewController {
    
    private let car: Car
    
    private func setUpImage(with urlString: String) {
        PhotoService.getImage(urlString: urlString) { [weak self] result in
            
            switch result {
            case .success(let image):
                self?.photoView.image = image
            case .failure(let error):
                print("Error on downloading image: \(error)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    private let titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = titleView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleView.addSubview(blurEffectView)
        return titleView
    }()
    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        return photoView
    }()
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.numberOfLines = 0
        return authorLabel
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    private let contentTextLabel: UILabel = {
        let contentTextLabel = UILabel()
        contentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextLabel.numberOfLines = 0
        return contentTextLabel
    }()
    private let contentTextView: UIView = {
        let contentTextView = UIView()
        contentTextView.backgroundColor = .white
        contentTextView.layer.cornerRadius = 20
        contentTextView.clipsToBounds = true
        return contentTextView
    }()
    private let rentButton: UIButton = {
        let rentButton = UIButton()
        rentButton.backgroundColor = .systemOrange
        rentButton.setTitle("Rent  ►", for: .normal)
        rentButton.addTarget(self, action: #selector(didTapRent), for: .touchUpInside)
        return rentButton
    }()
    
    @objc private func didTapRent(){
        navigationController?.pushViewController(CarRentingViewController(car: self.car), animated: true)
    }
    
    init(car: Car){
        self.car = car
        super.init(nibName: nil, bundle: nil)
        title = car.name
        authorLabel.text = "Rating: \(car.rating)✩"
        titleLabel.text = "\(car.pricePerDay)$ /Day"
        descriptionLabel.text = car.style.description
        dateLabel.text = "Style: \(car.style.rawValue)"
        contentTextLabel.text = car.overview
        setUpImage(with: car.imageUrl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        view.backgroundColor = .darkGray
        setupScrollView()
        layoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let path = UIBezierPath(roundedRect: rentButton.bounds,
                                byRoundingCorners:[.topLeft, .bottomRight],
                                cornerRadii: CGSize(width: 20, height:  20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        rentButton.layer.mask = maskLayer
        let otherPath = UIBezierPath(roundedRect: titleView.bounds,
                                byRoundingCorners:[.topLeft, .bottomRight],
                                cornerRadii: CGSize(width: 20, height:  20))
        let otherMask = CAShapeLayer()
        otherMask.path = otherPath.cgPath
        titleView.layer.mask = otherMask
    }
    
    func setupScrollView(){
        view.addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalToSuperview().dividedBy(2)
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func layoutSubviews() {
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.centerY).offset(-30)
            $0.leading.trailing.equalTo(view)
            $0.bottom.greaterThanOrEqualTo(view)
        }
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(contentTextLabel)
        layoutTitleView()
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleView.snp.bottom).offset(20)
        }
        contentTextLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        contentTextView.snp.makeConstraints {
            $0.bottom.greaterThanOrEqualTo(contentTextLabel)
        }
        contentView.addSubview(rentButton)
        rentButton.snp.makeConstraints{
            $0.trailing.top.bottom.equalTo(titleView).inset(5)
            $0.width.equalTo(60)
        }
    }
    private func layoutTitleView() {
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(contentTextView.snp.top)
        }
        titleView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(20)
        }
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
        }
        titleView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
