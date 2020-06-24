//
//  ViewController - TableView.swift
//  MartCalculator
//
//  Created by 신희욱 on 2020/06/17.
//  Copyright © 2020 AXI. All rights reserved.
//

import UIKit


extension ViewController: UITableViewDelegate {

}

class SumFooterView: UITableViewHeaderFooterView {
    var sum: Double = 0 {
        didSet {
            self.textLabel!.attributedText = footerAttrString()
            self.textLabel!.sizeToFit()
        }
    }
    
    private func footerAttrString() -> NSAttributedString? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.maximumSignificantDigits = 100
        
        let str = currencyFormatter.string(for: sum)!
        
        let array = sum.description.split(separator: ".")
        if array.count == 2 {
            let result = NSMutableAttributedString(string: str)
            let range = (str as NSString).range(of: ".\(array[1])")
            //result.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray4, range: range)
            result.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: range)
            return result
        } else {
            return NSAttributedString(string: str)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension ViewController: UITableViewDataSource {
    
    func registerCells() {
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "item")
        tableView.register(SumFooterView.self, forHeaderFooterViewReuseIdentifier: "sum")
    }
  
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sum") as! SumFooterView
        footerView.sum = calculator.sum()
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculator.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! ItemTableViewCell
        cell.item = calculator.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.context.delete(calculator.items[indexPath.row])
            calculator.items.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [ indexPath ], with: .automatic)
            updateSum()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectType = nil
        selectedItemIndexPath = indexPath
        let item = calculator.items[indexPath.row]
        //print(item)
        name = item.name
        price = String(item.price)
        count = String(item.count)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        footer.contentView.backgroundColor = .black
        footer.textLabel?.textColor = UIColor.white
        footer.textLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        footer.textLabel?.frame = footer.frame
        footer.textLabel?.textAlignment = .natural
    }
    
}
