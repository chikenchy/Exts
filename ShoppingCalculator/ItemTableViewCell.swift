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
                let allPrice = (Double(item.count) * item.price).removeZerosFromEnd()
                print("Float(item.count): \(Float(item.count))")
                print("item.price: \(item.price)")
                print("allPrice: \(allPrice)")
                nameLbl.text = item.name
                priceLbl.text = "\(item.price.removeZerosFromEnd())"
                countLbl.text = "×\(item.count)"
                allPriceLbl.text = "\(allPrice)"
                
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
