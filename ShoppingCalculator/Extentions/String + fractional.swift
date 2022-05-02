import Foundation

extension Double {
    
    func fractional() -> Double {
        let int = Int(self)
        let result = self - Double(int)
        return result
    }
    
}
