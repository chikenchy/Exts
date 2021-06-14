import Foundation

extension Double {
    
    func fractional() -> Double {
        let int = Int(self)
        let result = self - Double(int)
        print(result)
        return result
    }
    
}
