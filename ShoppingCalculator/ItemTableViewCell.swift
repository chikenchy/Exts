import UIKit

final class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var allPriceLbl: UILabel!
    
    var item: MartItem? {
        didSet {
            if let item = item {
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .decimal
                currencyFormatter.usesGroupingSeparator = true
                currencyFormatter.maximumSignificantDigits = 100
                
                let sum = Decimal(item.count) * Decimal(item.price)
                let allPrice = currencyFormatter.string(for: sum)!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
