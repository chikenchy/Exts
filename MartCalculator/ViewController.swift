//
//  ViewController.swift
//  MartCalculator
//
//  Created by 신희욱 on 2020/06/16.
//  Copyright © 2020 AXI. All rights reserved.
//

import UIKit
import CoreData

class Calculator {
    
    var items = [MartItem]()
    
    func load(hostory: History) {
        
    }
    
    func add(item: MartItem) {
        items.append(item)
    }
    
    func sum() -> Float {
        var sum:Float = 0
        for item in items {
            sum += item.price * Float(item.count)
        }
        return sum
    }
    
    func clear() {
        items.removeAll()
    }
}

enum BtnType: Equatable {
    case digit(str: String)
    case allClear
    case clear
    case price
    case count
    case dot
    case add
}

class ViewController: UIViewController {
    
    var dotIdx:Int = 0 {
        didSet {
            updateDotBtn()
        }
    }
    
    private func updateDotBtn() {
        if switchsPriceOrCountType == .price {
            dotBtn.isEnabled = dotIdx < 1
        } else {
            dotBtn.isEnabled = false
        }
    }
    
    
    let calculator = Calculator()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var digit0: UIButton!
    @IBOutlet weak var digit000: UIButton!
    @IBOutlet weak var dotBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var digit1: UIButton!
    @IBOutlet weak var digit2: UIButton!
    @IBOutlet weak var digit3: UIButton!
    @IBOutlet weak var priceOrCountBtn: UIButton!
    
    @IBOutlet weak var digit4: UIButton!
    @IBOutlet weak var digit5: UIButton!
    @IBOutlet weak var digit6: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    @IBOutlet weak var digit7: UIButton!
    @IBOutlet weak var digit8: UIButton!
    @IBOutlet weak var digit9: UIButton!
    @IBOutlet weak var allClearBtn: UIButton!
    
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var priceLbl: UITextField!
    @IBOutlet weak var countLbl: UITextField!
    
    
    private var name: String? {
        didSet {
            nameLbl.text = name
        }
    }
    
    private var price: Float = 0 {
        didSet {
//            if price.truncatingRemainder(dividingBy: 1) == 0 {
//                priceLbl.text = String(format: "%.0f\(UserSetting.currency)", price)
//            } else {
//                priceLbl.text = "\(price)\(UserSetting.currency)"
//            }
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .decimal
            currencyFormatter.locale = Locale.current
            priceLbl.text = currencyFormatter.string(for: price)
        }
    }
    private var count: Int = 1 {
        didSet {
            countLbl.text = "\(count)개"
        }
    }
    
    
    @IBAction func onTouchUpInside_Btn(_ sender: UIButton) {
        let btnType: BtnType?
        switch sender.titleLabel!.text {
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "00", "000":
            let str = sender.titleLabel!.text!
            btnType = .digit(str: str)
        case ".":
            btnType = .dot
        case "C":
            btnType = .clear
        case "AC":
            btnType = .allClear
        case "가격":
            btnType = .price
        case "갯수":
            btnType = .count
        case "추가":
            btnType = .add
        default:
            fatalError()
        }
        
        switch btnType! {
        case .digit(let str):
            switch str {
            case "0", "00", "000":
                if switchsPriceOrCountType == .price {
                    if dotIdx > 0 {
                        for _ in 0..<str.count {
                            dotIdx += 1
                        }

                    } else {
                        if price > 0 {
                            for _ in 0..<str.count {
                                price *= 10
                            }
                        }
                    }
                } else {
                    if count > 0 {
                        for _ in 0..<str.count {
                            if case let (result, overflow) = count.multipliedReportingOverflow(by: 10), !overflow {
                                count = result
                            } else {
                                print("overflow")
                                break
                            }
                        }
                    }
                }
            case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if switchsPriceOrCountType == .price {
                    if dotIdx > 0 {
                        var addValue = Float(str)!
                        for _ in 0..<dotIdx {
                            addValue /= 10
                        }
                        
                        price += addValue
                        
                        dotIdx += 1
                        
                    } else {
                        price *= 10
                        price += Float(str)!
                    }
                } else {
                    if case let (result, overflow) = count.multipliedReportingOverflow(by: 10), !overflow {
                        count = result
                        count += Int(str)! //TODO
                    } else {
                        print("overflow")
                    }
                }
            default: break
            }
        case .dot:
            dotIdx = 1
        case .allClear:
            clearAll()
        case .clear:
            clearCurrent()
        case .price, .count:
            switchsPriceOrCountBtn()
        case .add:
            guard price > 0 else {
                return
            }
            let item = MartItem(context: CoreDataManager.shared.context)
            item.count = Int32(count)
            item.price = price
            item.name = nameLbl.text
            item.createdAt = Date()
            calculator.add(item: item)
            clearCurrent()
            
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: calculator.items.count-1, section: 0)], with: .automatic)
            tableView.footerView(forSection: 0)!.textLabel!.text = footerString()
            tableView.footerView(forSection: 0)!.textLabel!.sizeToFit()
            tableView.endUpdates()
            
            switchsPriceOrCountType = .price
        }
    }
    
    private func clearCurrent() {
        dotIdx = 0
        name = nil
        price = 0
        count = 1
    }
    
    private func clearAll() {
        clearCurrent()
        calculator.clear()
        tableView.reloadData()
    }
    
    var switchsPriceOrCountType = BtnType.price {
        didSet {
            if switchsPriceOrCountType == .price {
                priceOrCountBtn.titleLabel!.text = "갯수"
                priceOrCountBtn.titleLabel!.sizeToFit()
            } else {
                priceOrCountBtn.titleLabel!.text = "가격"
                priceOrCountBtn.titleLabel!.sizeToFit()
            }
            updateDotBtn()
        }
    }
    
    private func switchsPriceOrCountBtn() {
        if switchsPriceOrCountType == .price {
            switchsPriceOrCountType = .count
        } else {
            switchsPriceOrCountType = .price
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        
        nameLbl.delegate = self
        
        clearCurrent()
        switchsPriceOrCountType = .price
        
        digit0.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit000.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        dotBtn.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit1.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit2.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit3.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        priceOrCountBtn.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit4.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit5.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit6.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit7.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit8.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        digit9.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        clearBtn.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
        allClearBtn.addTarget(self, action: #selector(onTouchUpInside_Btn), for: .touchUpInside)
    }
    
}

