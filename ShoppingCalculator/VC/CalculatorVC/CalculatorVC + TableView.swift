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
        footerView.currencyCode = currencyCode
        footerView.sumRelay.accept(calculator.sum())
        footerView.saveRelay
            .bind(with: self) { `self`, _ in
                let numbers = [0]
                let _ = numbers[1]
                
                
                guard !appRatingServiceSingleton.check() else {
                    appRatingServiceSingleton.incrementSignificantUsageCount()
                    return
                }
                
                if Bool.random() {
                    admobServiceSingleton.loadInterstitialIfNeeded { result in
                        switch result {
                        case .success(_):
                            admobServiceSingleton.showInterstitial { result in
                                switch result {
                                case .success(_):
                                    self.calculator.save()
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    self.calculator.save()
                }
            }
            .disposed(by: footerView.bag)
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculator.data?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! ItemTableViewCell
        cell.item = calculator.data!.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            calculator.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateSum()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectType = nil
        selectedItemIndexPath = indexPath
        
        if let item = calculator.data?.items[indexPath.row] {
            name = item.name
            price = item.price.description
            count = String(item.count)
        }
    }
    
}
