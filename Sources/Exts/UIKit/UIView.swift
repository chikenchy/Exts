#if canImport(UIKit)

import UIKit

extension UIView {
    
    public func addSubviews(_ views: UIView ...) {
        views.forEach { self.addSubview($0) }
    }
    
}

#endif
