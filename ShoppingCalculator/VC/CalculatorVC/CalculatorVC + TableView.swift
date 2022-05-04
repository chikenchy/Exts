import UIKit
import Then

extension CalculatorVC: UITableViewDelegate {
    
}

extension CalculatorVC: UITableViewDataSource {
    
    func registerCells() {
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "item")
        tableView.register(CalculatorSumFooterView.self, forHeaderFooterViewReuseIdentifier: "sum")
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sum") as! CalculatorSumFooterView
        footerView.sum = calculator.sum()
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
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
        
        name = item.name
        price = String(item.price)
        count = String(item.count)
    }
    
//    func tableView(
//        _ tableView: UITableView,
//        willDisplayFooterView view: UIView,
//        forSection section: Int
//    ) {
//        guard let footer = view as? UITableViewHeaderFooterView else { return }
//
//        footer.setNeedsLayout()
//        footer.layoutIfNeeded()
//
//        let height = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//        footer.frame.size = .init(width: footer.frame.width, height: height)
//    }
    
}
