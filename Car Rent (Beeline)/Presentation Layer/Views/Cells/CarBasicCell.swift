
import UIKit
import SnapKit

typealias CarBasicCellConfigurator = CollectionCellConfigurator<CarBasicCell, Car>

//MARK: - Photo Cell for Home Page

class CarBasicCell: UICollectionViewCell {
    
    static let identifier = "CarBasicCell"
        
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return nameLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        return priceLabel
    }()
    
    private let details: UILabel = {
        let details = UILabel()
        details.textColor = .white
        details.text = "Details"
        details.textAlignment = .center
        details.font = .systemFont(ofSize: 22, weight: .bold)
        return details
    }()
    
    private let bottomRightView: UIView = {
        let bottomRightView = UIView()
        bottomRightView.backgroundColor = .link
        bottomRightView.clipsToBounds = true
        bottomRightView.layer.cornerRadius = 40
        return bottomRightView
    }()
    
    private let topGradientView: GradientView = {
        let topGradientView = GradientView(gradientColor: .link)
        return topGradientView
    }()

    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        return photoView
    }()
    
    @objc private func didTapDetails(){
        Action.custom("didTapDetails").invoke(cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 40
        contentView.clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDetails))
        bottomRightView.addGestureRecognizer(gesture)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()

    }
    
    private func layout(){
        contentView.addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.addSubview(topGradientView)
        topGradientView.snp.makeConstraints{
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(70)
        }
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(photoView).inset(20)
        }
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
        }
        contentView.addSubview(bottomRightView)
        bottomRightView.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.bottom).inset(40)
            $0.leading.equalTo(contentView.snp.trailing).inset(200)
            $0.size.equalTo(300)
        }
        contentView.addSubview(details)
        details.snp.makeConstraints{
            $0.top.leading.equalTo(bottomRightView)
            $0.trailing.bottom.equalToSuperview()
        }
    }
    private func priceAttribtedString(with price: Double) -> NSMutableAttributedString {
        
        let firstAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)]
        
        let secondAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        
        let partOne = NSMutableAttributedString(string: "\(String(price))$", attributes: firstAttribute)
        let partTwo = NSMutableAttributedString(string: " /Day", attributes: secondAttribute)
        partOne.append(partTwo)
        
        return partOne
    }
}




//MARK: - Set as Configurable Cell

extension CarBasicCell: ConfigurableCell {
    
    typealias DataType = Car
    
    func configure(data: Car) {
        self.nameLabel.text = data.name
        self.priceLabel.attributedText = priceAttribtedString(with: data.pricePerDay)
        if data.isAvailable {
            bottomRightView.backgroundColor = .link
        } else {
            bottomRightView.backgroundColor = .gray
        }
        setUpImage(with: data.imageUrl)
    }
    
    // loads image by string url
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
    
}
