import UIKit

final class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var allPriceLbl: UILabel!
    
    var item: MarketItem? {
        didSet {
            if let item = item {
                let currencyFormatter = NumberFormatter().then {
                    $0.numberStyle = .decimal
                    $0.usesGroupingSeparator = true
                    $0.maximumSignificantDigits = 100
                }
                
                let allPrice = currencyFormatter.string(for: item.sum)!
                let price = currencyFormatter.string(for: item.price)!
                nameLbl.text = item.name
                priceLbl.text = price
                countLbl.text = "×\(item.count)"
                allPriceLbl.text = allPrice
                
                if item.price <= 0 {
                    backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.02)
                }
            } else {
                nameLbl.text = ""
                priceLbl.text = "0"
                countLbl.text = "1"
                allPriceLbl.text = "x0"
                
                backgroundColor = .clear
            }
        }
    }
    
    override func prepareForReuse() {
        item = nil
    }
    
}

extension Double {
    
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter().then {
            $0.minimumFractionDigits = 0
            $0.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        }
        let number = NSNumber(value: self)
        return String(formatter.string(from: number) ?? "")
    }
    
}
