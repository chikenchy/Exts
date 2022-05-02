import UIKit

final class CalculatorSumFooterView: UITableViewHeaderFooterView {
    var sum: String = "0" {
        didSet {
            self.textLabel!.attributedText = footerAttrString()
            self.textLabel!.sizeToFit()
        }
    }
    
    private func footerAttrString() -> NSAttributedString? {
        let currencyFormatter = NumberFormatter().then {
            $0.usesGroupingSeparator = true
            $0.numberStyle = .currency
            $0.locale = Locale.current
            $0.maximumSignificantDigits = 100
        }
        
        let formatter = NumberFormatter()
        let num = formatter.number(from: sum)!
        let str = currencyFormatter.string(from: num)!
        
        let array = sum.description.split(separator: ".")
        if array.count == 2 {
            let result = NSMutableAttributedString(string: str)
            let range = (str as NSString).range(of: ".\(array[1])")
            result.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: range)
            result.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: range)
            return result
        } else {
            return NSAttributedString(string: str)
        }
    }
    
}
