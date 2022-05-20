import UIKit

public extension UIColor {
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}
