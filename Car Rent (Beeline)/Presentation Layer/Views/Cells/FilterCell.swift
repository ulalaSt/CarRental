
import UIKit
import SnapKit
import DropDown

typealias FilterCellConfigurator = CollectionCellConfigurator<FilterCell, FilterData>

//MARK: - Photo Cell for Home Page
class FilterCell: UICollectionViewCell {
    
    var currentTitle: String = "All"
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.sizeToFit()
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    private let chooseButton: UIButton = {
        let chooseButton = UIButton()
        chooseButton.setTitle("All", for: .normal)
        chooseButton.backgroundColor = .systemOrange
        chooseButton.setTitleColor(.white, for: .application)
        chooseButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        return chooseButton
    }()
    
    private let dropIcon: UIImageView = {
        let dropIcon = UIImageView()
        dropIcon.image = UIImage(systemName: "arrowtriangle.down.fill")
        dropIcon.tintColor = .white
        dropIcon.contentMode = .scaleAspectFit
        return dropIcon
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        let path = UIBezierPath(roundedRect: chooseButton.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: 15, height:  15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        chooseButton.layer.mask = maskLayer
    }
    private let menu: DropDown = {
        let menu = DropDown()
        return menu
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapMenu(){
        menu.show()
    }
    
    private func layout(){
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints{
            $0.leading.bottom.top.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
        }
        contentView.addSubview(chooseButton)
        chooseButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(5)
            $0.leading.equalTo(nameLabel.snp.trailing).inset(-5)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(25)
        }
        contentView.addSubview(dropIcon)
        dropIcon.snp.makeConstraints{
            $0.trailing.equalTo(chooseButton).inset(3)
            $0.bottom.equalTo(chooseButton)
            $0.size.equalTo(10)
        }
        layoutIfNeeded()

    }
    
    private func setMenu(){
        menu.anchorView = contentView
        menu.selectionAction = { [weak self] index, title in
            self?.currentTitle = title
            self?.didSelectMenuItem()
        }
    }
    
    private func didSelectMenuItem(){
        Action.custom("didSelectMenuItem").invoke(cell: self)
    }
}




//MARK: - Set as Configurable Cell

extension FilterCell: ConfigurableCell {
    
    typealias DataType = FilterData
    
    func configure(data: FilterData) {
        self.nameLabel.text = data.name
        
        var dataSource = ["All"]
        dataSource.append(contentsOf: data.selectionRange)
        self.menu.dataSource = dataSource
        
        if let currentState = data.currentState{
            chooseButton.setTitle(currentState, for: .normal)
        } else {
            chooseButton.setTitle("All", for: .normal)
        }
    }
        
}
