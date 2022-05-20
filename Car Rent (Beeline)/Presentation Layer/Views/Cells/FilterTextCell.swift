
import UIKit
import SnapKit

typealias FilterTextCellConfigurator = CollectionCellConfigurator<FilterTextCell, FilterTextCellData>

//MARK: - Photo Cell for Home Page
class FilterTextCell: UICollectionViewCell {
    
    var currentMin: String? = nil
    var currentMax: String? = nil
    
    private let minTextField: UITextField = {
        let minTextField = UITextField()
        minTextField.textColor = .white
        minTextField.textAlignment = .justified
        minTextField.attributedPlaceholder = NSAttributedString(
            string: "from",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        minTextField.backgroundColor = .gray
        return minTextField
    }()
    
    private let maxTextField: UITextField = {
        let maxTextField = UITextField()
        maxTextField.textColor = .white
        maxTextField.textAlignment = .justified
        maxTextField.attributedPlaceholder = NSAttributedString(
            string: "to",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        maxTextField.backgroundColor = .gray
        return maxTextField
    }()
    
    private let textFieldView: UIView = {
        let textFieldView = UIView()
        textFieldView.layer.cornerRadius = 5
        textFieldView.clipsToBounds = true
        return textFieldView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        minTextField.delegate = self
        maxTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
    private func layout(){
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints{
            $0.leading.bottom.top.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
        }
        contentView.addSubview(textFieldView)
        textFieldView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(nameLabel.snp.trailing).inset(-5)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(25)
        }
        textFieldView.addSubview(minTextField)
        minTextField.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        textFieldView.addSubview(maxTextField)
        maxTextField.snp.makeConstraints{
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(minTextField.snp.trailing).offset(2)
        }
    }
}




//MARK: - Set as Configurable Cell

extension FilterTextCell: ConfigurableCell {
    
    typealias DataType = FilterTextCellData
    
    func configure(data: FilterTextCellData) {
        self.nameLabel.text = data.name
    }
}

extension FilterTextCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .systemOrange
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.hasText {
            textField.backgroundColor = .systemOrange
        } else {
            textField.backgroundColor = .gray
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        currentMax = maxTextField.text
        currentMin = minTextField.text
        Action.custom("didReturnPriceRange").invoke(cell: self)
        return true
    }
}
