import Eureka

final class SettingsVC: FormViewController {
    
    override func loadView() {
        super.loadView()
        title = NSLocalizedString("Settings", comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section(NSLocalizedString("CurrencySetting", comment: ""))
        
        <<< SwitchRow("useDeviceCurrency"){
            $0.title = NSLocalizedString("DeviceSettingCurrency", comment: "")
            $0.value = userSettingServiceSingleton.userSetting.useDeviceCurrency
            $0.onChange { row in
                userSettingServiceSingleton.userSetting.useDeviceCurrency = row.value!
            }
            $0.cellUpdate { cell, row in
                row.value = userSettingServiceSingleton.userSetting.useDeviceCurrency
            }
        }
        <<< PickerRow<String>("allCurrency") { (row: PickerRow<String>) -> Void in
            row.hidden = Condition.function(["useDeviceCurrency"], { form in
                return ((form.rowBy(tag: "useDeviceCurrency") as? SwitchRow)?.value ?? false)
            })
            row.options = []
            
            let locale = NSLocale.current as NSLocale
            for code in Locale.commonISOCurrencyCodes {
                guard let currencyName = locale.displayName(forKey: NSLocale.Key.currencyCode, value: code) else { continue }
                guard let currencySymbol = locale.displayName(forKey:NSLocale.Key.currencySymbol, value: code) else { continue }
                
                let value = "\(currencyName) \(currencySymbol)"
                row.options.append(value)
                
                if code == userSettingServiceSingleton.currencyCode {
                    row.value = value
                }
            }
            
            row.onChange { row in
                for code in Locale.commonISOCurrencyCodes {
                    guard let currencyName = locale.displayName(forKey: NSLocale.Key.currencyCode, value: code) else { continue }
                    guard let currencySymbol = locale.displayName(forKey:NSLocale.Key.currencySymbol, value: code) else { continue }
                    
                    let value = "\(currencyName) \(currencySymbol)"
                    
                    if row.value == value {
                        userSettingServiceSingleton.userSetting.userCurrencyCode = code
                        break
                    }
                }
            }
            row.cellUpdate { cell, row in
                let locale = NSLocale.current as NSLocale
                for code in Locale.commonISOCurrencyCodes {
                    guard let currencyName = locale.displayName(forKey: NSLocale.Key.currencyCode, value: code) else { continue }
                    guard let currencySymbol = locale.displayName(forKey:NSLocale.Key.currencySymbol, value: code) else { continue }
                    
                    let value = "\(currencyName) \(currencySymbol)"
                    
                    if code == userSettingServiceSingleton.currencyCode {
                        row.value = value
                    }
                }
            }
        }
        
        +++ Section(NSLocalizedString("HistorySetting", comment: ""))
        <<< DoublePickerInlineRow<HistorySortColumn, HistorySortOrder>("Sort") {
            $0.title = NSLocalizedString("Sort", comment: "")
            $0.firstOptions = { () -> [HistorySortColumn] in
                return [
                    .createdAt,
                    .updatedAt,
                ]
            }
            $0.secondOptions = { (_) -> [HistorySortOrder] in
                return [
                    .acs,
                    .desc,
                ]
            }
            $0.value = .init(
                a: userSettingServiceSingleton.userSetting.sortColumn,
                b: userSettingServiceSingleton.userSetting.sortOrder
            )
            $0.onChange { row in
                let column = row.value!.a
                let order = row.value!.b
                
                userSettingServiceSingleton.userSetting.sortColumn = column
                userSettingServiceSingleton.userSetting.sortOrder = order
                
                let notificaiton = Notification(
                    name: .HistorySettingChanged,
                    object: self,
                    userInfo: [
                        "column": column,
                        "order": order,
                    ]
                )
                NotificationCenter.default.post(notificaiton)
            }
            $0.cellUpdate { cell, row in
                row.value = .init(
                    a: userSettingServiceSingleton.userSetting.sortColumn,
                    b: userSettingServiceSingleton.userSetting.sortOrder
                )
            }
        }
        
        +++ Section()
        <<< ButtonRow() {
            $0.title = NSLocalizedString("Reset", comment: "")
        }
        .onCellSelection { [weak self] (cell, row) in
            let alert = UIAlertController(
                title: nil,
                message: NSLocalizedString("ResetPopupDesc", comment: ""),
                preferredStyle: UIAlertController.Style.alert
            ).then { alert in
                alert.addAction(.init(title: "OK", style: .destructive) { _ in
                    self!.reset()
                })
                alert.addAction(.init(title: "Cancel", style: .cancel))
            }
            self?.present(alert, animated: true)
        }
        
        //        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
        //        for option in continents {
        //            form.last! <<< ListCheckRow<String>(option){ listRow in
        //                listRow.title = option
        //                listRow.selectableValue = option
        //                listRow.value = nil
        //            }
        //        }
        //
        //        form.last!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userSettingServiceSingleton.saveToUserDefault()
    }
    
    private func reset() {
        userSettingServiceSingleton.reset()
        userSettingServiceSingleton.saveToUserDefault()
        
        if let sortRow = self.form.rowBy(tag: "Sort") as? DoublePickerInlineRow<HistorySortColumn, HistorySortOrder> {
            sortRow.collapseInlineRow()
        }
        
        self.form.allRows.forEach {
            $0.updateCell()
            $0.reload()
        }
    }
}
