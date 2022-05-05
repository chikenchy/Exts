import Foundation


struct MarketItem: Codable {
    var count: Int
    var price: Decimal
    var name: String?
    
    var sum: Decimal {
        get { price * Decimal(count) }
    }
}

struct HistoryData: Codable {
    var items: [MarketItem]
    var commonISOCurrencyCode: String // Locale.commonISOCurrencyCodes
}

protocol CalculatorDelegate: AnyObject {
    func calculator(_ calculator: Calculator, loadedHistory: History)
    func calculator(_ calculator: Calculator, isDirty: Bool)
}

final class Calculator {
    weak var delegate: CalculatorDelegate?
    private var userSettingService: UserSettingService
    private(set) var data: HistoryData?
    private(set) var history: History?
    private(set) var isDirty = false
    
    
    init(userSettingService: UserSettingService) {
        self.userSettingService = userSettingService
    }
    
    func load(history: History) throws {
        if let data = history.data {
            do {
                let data = try JSONDecoder().decode(HistoryData.self, from: data)
                
                self.data = data
                self.history = history
            } catch {
                throw error
            }
            
            if isDirty {
                isDirty.toggle()
                delegate?.calculator(self, isDirty: isDirty)
            }
            
            delegate?.calculator(self, loadedHistory: history)
        } else {
//            throw DecodingError
        }
    }
    
    func add(count: Int, price: Decimal, name: String?) {
        let addItem = MarketItem(count: count, price: price, name: name)
        
        if data == nil {
            data = .init(
                items: [addItem],
                commonISOCurrencyCode: userSettingService.currencyCode
            )
        } else {
            data!.items.append(addItem)
        }
        
        if !isDirty {
            isDirty.toggle()
            delegate?.calculator(self, isDirty: isDirty)
        }
    }
    
    func update(at: Int, count: Int, price: Decimal, name: String?) {
        if data == nil { return }
        
        data?.items[at].count = count
        data?.items[at].price = price
        data?.items[at].name = name
        
        if !isDirty {
            isDirty.toggle()
            delegate?.calculator(self, isDirty: isDirty)
        }
    }
    
    func remove(at: Int) {
        data?.items.remove(at: at)
        
        if !isDirty {
            isDirty.toggle()
            delegate?.calculator(self, isDirty: isDirty)
        }
    }
    
    func sum() -> Decimal {
        var sum:Decimal = Decimal(0)
        data?.items.forEach { item in
            let add = item.price * Decimal(item.count)
            sum += add
        }
        return sum
    }
    
    func clear() {
        history = nil
        data = nil
        
        if isDirty {
            isDirty.toggle()
            delegate?.calculator(self, isDirty: isDirty)
        }
    }
    
    func save() {
        guard isDirty else { return }
        guard let data = data else { return }
        
        if let history = history {
            history.updatedAt = Date()
        } else {
            let history = History(context: CoreDataManager.shared.context).then {
                $0.id = UUID()
                $0.createdAt = Date()
            }
            self.history = history
        }
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            history?.data = jsonData
        } catch {
            print(error.localizedDescription)
            return
        }
        
        history?.willSave()
        CoreDataManager.shared.saveContext()
        
        if isDirty {
            isDirty.toggle()
            delegate?.calculator(self, isDirty: isDirty)
        }
    }
}
