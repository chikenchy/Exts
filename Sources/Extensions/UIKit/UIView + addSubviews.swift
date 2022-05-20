#if canImport(UIKit)

import UIKit

public extension UIView {
    
    func addSubviews(_ views: UIView ...) {
        views.forEach { self.addSubview($0) }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
}

#endif
