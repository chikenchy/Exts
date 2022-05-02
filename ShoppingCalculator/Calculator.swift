import Foundation

final class Calculator {
    var items = [MartItem]()
    var history: History?
    
    func load(history: History) {
        self.history = history
        
        items.removeAll()
        if let martItems = history.martItems as? Set<MartItem> {
            items.append(contentsOf: martItems)
        }
    }
    
    func add(count: Int64, price: Double, name: String?) {
        let item = MartItem(context: CoreDataManager.shared.context).then {
            $0.count = count
            $0.price = price
            $0.name = name
            $0.createdAt = Date()
        }
        
        if self.history == nil {
            let new = History(context: CoreDataManager.shared.context).then {
                $0.id = UUID()
                $0.createdAt = Date()
            }
            self.history = new
        }
        
        self.history?.updatedAt = Date()
        self.history?.addToMartItems(item)
        
        items.append(item)
    }
    
    func sum() -> String {
        var sum:Decimal = Decimal(0)
        for item in items {
            let add = Decimal(item.price) * Decimal(item.count)
            sum += add
        }
        return sum.description
    }
    
    func clear() {
        if let history = self.history {
            history.willSave()
            
            self.history = nil
        }
        
        items.removeAll()
        
        CoreDataManager.shared.saveContext()
    }
}
