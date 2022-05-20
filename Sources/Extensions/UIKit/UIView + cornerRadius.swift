import UIKit

public extension UIView {
    
    func cornerRadius(radius: CGFloat, rectCorner: UIRectCorner) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: rectCorner.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: self.bounds,
                byRoundingCorners: rectCorner,
                cornerRadii: CGSize(width:radius, height: radius)
            )
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            
            layer.mask = maskLayer
        }
    }
}
