#if canImport(UIKit)

import UIKit

public extension UIView {
    
    func addSubviews(_ views: UIView ...) {
        views.forEach { self.addSubview($0) }
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

#endif
