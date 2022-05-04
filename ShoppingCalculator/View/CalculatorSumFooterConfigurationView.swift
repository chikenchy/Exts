import UIKit
import Then

final class CalculatorSumFooterConfigurationView: UITableViewHeaderFooterView {
    var sum: String = "0" {
        didSet {
            var content = UIListContentConfiguration.plainFooter()
            content.textProperties.color = UIColor.white
            content.textProperties.font = UIFont.boldSystemFont(ofSize: 25)
            content.attributedText = footerAttrString()
            self.contentConfiguration = content
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
    }
}
