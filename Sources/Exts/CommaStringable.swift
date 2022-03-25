
import Foundation

protocol CommaStringable {
    func commaString() -> String
}

extension Int: CommaStringable {
    
    func commaString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}

extension Double: CommaStringable {
    
    func commaString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}
