import Foundation

public extension TimeInterval {
    
    enum RoundingType {
        case cell, floor, round
    }
    
    func toMinutes(_ type: RoundingType) -> Int {
        switch type {
        case .cell:
            return Int(ceil(self/60))
        case .floor:
            return Int(floor(self/60))
        case .round:
            return Int(self.rounded()/60)
        }
    }
    
    func toHours(_ type: RoundingType) -> Int {
        switch type {
        case .cell:
            return Int(ceil(self/3600))
        case .floor:
            return Int(floor(self/3600))
        case .round:
            return Int(self.rounded()/3600)
        }
    }
    
}
