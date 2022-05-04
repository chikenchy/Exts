import UIKit
import Then
import SnapKit

final class CalculatorSumFooterView: UITableViewHeaderFooterView {
    let sumLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textColor = .white
    }
    let saveButton = UIButton().then {
        $0.titleLabel?.text = "세이브"//NSLocalizedString("Save", comment: "")
        $0.titleLabel?.font = .preferredFont(forTextStyle: .body)
        UIFont.boldSystemFont(ofSize: 25)
        $0.titleLabel?.textColor = .white
//        $0.titleLabel?.sizeToFit()
    }
    
    var sum: String = "0" {
        didSet {
            self.sumLabel.attributedText = footerAttrString()
        }
    }
    
    private func footerAttrString() -> NSAttributedString? {
        let num = NumberFormatter().number(from: sum)!
        let str = NumberFormatter().then {
            $0.usesGroupingSeparator = true
            $0.numberStyle = .currency
            $0.locale = Locale.current
            $0.maximumSignificantDigits = 100
        }.string(from: num)!
        
        let array = sum.description.split(separator: ".")
        if array.count == 2 {
            let result = NSMutableAttributedString(string: str)
            let range = (str as NSString).range(of: ".\(array[1])")
            result.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: range)
            result.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: range)
            return result
        } else {
            return NSAttributedString(
                string: str,
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]
            )
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        sharedInit()
    }
    
    private func sharedInit() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(sumLabel)
        contentView.addSubview(saveButton)
        
        sumLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
