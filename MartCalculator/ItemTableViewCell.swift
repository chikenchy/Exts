//
//  ItemTableViewCell.swift
//  MartCalculator
//
//  Created by 신희욱 on 2020/06/17.
//  Copyright © 2020 AXI. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var allPriceLbl: UILabel!
    
    var item: MartItem? {
        didSet {
            if let item = item {
                let currencyFormatter = NumberFormatter()
                currencyFormatter.usesGroupingSeparator = true
                currencyFormatter.numberStyle = .currency
                currencyFormatter.locale = Locale.current
                let priceStr = currencyFormatter.string(for: item.price)
                let allPriceStr = currencyFormatter.string(for: item.price * Float(item.count))
                
                nameLbl.text = item.name
                priceLbl.text = priceStr
                countLbl.text = "\(item.count)개"
                allPriceLbl.text = allPriceStr
            } else {
                nameLbl.text = ""
                priceLbl.text = "0\(UserSetting.currency)"
                countLbl.text = "1개"
                allPriceLbl.text = "0\(UserSetting.currency)"
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
