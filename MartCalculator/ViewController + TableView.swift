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

extension ViewController: UITableViewDataSource {
    
    func registerCells() {
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "item")
    }
    
    func footerString() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(for: calculator.sum())
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        footerString()
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
            
//            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}
