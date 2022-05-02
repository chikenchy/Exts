import Foundation

public protocol CommaStringable {
    func commaString() -> String
}

extension Int: CommaStringable {
    
    public func commaString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}

extension Double: CommaStringable {
    
    public func commaString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}
