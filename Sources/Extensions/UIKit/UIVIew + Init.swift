//#if canImport(UIKit)
//
//import UIKit
//
//public extension UIView {
//    
//    convenience init(
//        alpha: CGFloat? = nil,
//        autoresizesSubviews: Bool? = nil,
//        autoresizingMask: AutoresizingMask? = nil,
//        backgroundColor: UIColor? = nil,
//        clipsToBounds: Bool? = nil,
//        contentMode: ContentMode? = nil,
//        frame: CGRect? = nil,
//        isHidden: Bool? = nil,
//        isMultipleTouchEnabled: Bool? = nil,
//        isOpaque: Bool? = nil,
//        isUserInteractionEnabled: Bool? = nil,
//        tag: Int? = nil,
//        tintAdjustmentMode: TintAdjustmentMode? = nil,
//        tintColor: UIColor? = nil
//    ) {
//        self.init()
//        
//        if let alpha = alpha {
//            self.alpha = alpha
//        }
//        
//        if let autoresizesSubviews = autoresizesSubviews {
//            self.autoresizesSubviews = autoresizesSubviews
//        }
//        
//        if let autoresizingMask = autoresizingMask {
//            self.autoresizingMask = autoresizingMask
//        }
//        
//        if let backgroundColor = backgroundColor {
//            self.backgroundColor = backgroundColor
//        }
//        
//        if let clipsToBounds = clipsToBounds {
//            self.clipsToBounds = clipsToBounds
//        }
//        
//        if let contentMode = contentMode {
//            self.contentMode = contentMode
//        }
//        
//        if let frame = frame {
//            self.frame = frame
//        }
//        
//        if let isHidden = isHidden {
//            self.isHidden = isHidden
//        }
//        
//        if let isMultipleTouchEnabled = isMultipleTouchEnabled {
//            self.isMultipleTouchEnabled = isMultipleTouchEnabled
//        }
//        
//        if let isOpaque = isOpaque {
//            self.isOpaque = isOpaque
//        }
//        
//        if let isUserInteractionEnabled = isUserInteractionEnabled {
//            self.isUserInteractionEnabled = isUserInteractionEnabled
//        }
//        
//        if let tag = tag {
//            self.tag = tag
//        }
//        
//        if let tintAdjustmentMode = tintAdjustmentMode {
//            self.tintAdjustmentMode = tintAdjustmentMode
//        }
//        
//        if let tintColor = tintColor {
//            self.tintColor = tintColor
//        }
//    }
//}
//
//
//public extension UILabel {
//    
//    convenience init(
//        adjustsFontSizeToFitWidth: Bool? = nil,
//        alpha: CGFloat? = nil,
//        autoresizesSubviews: Bool? = nil,
//        autoresizingMask: AutoresizingMask? = nil,
//        backgroundColor: UIColor? = nil,
//        clipsToBounds: Bool? = nil,
//        contentMode: ContentMode? = nil,
//        font: UIFont? = nil,
//        frame: CGRect? = nil,
//        isHidden: Bool? = nil,
//        isMultipleTouchEnabled: Bool? = nil,
//        isOpaque: Bool? = nil,
//        isUserInteractionEnabled: Bool? = nil,
//        numberOfLines: Int? = nil,
//        tag: Int? = nil,
//        text: String? = nil,
//        textAlignment: NSTextAlignment? = nil,
//        textColor: UIColor? = nil,
//        tintAdjustmentMode: TintAdjustmentMode? = nil,
//        tintColor: UIColor? = nil
//    ) {
//        self.init(
//            alpha: alpha,
//            autoresizesSubviews: autoresizesSubviews,
//            autoresizingMask: autoresizingMask,
//            backgroundColor: backgroundColor,
//            clipsToBounds: clipsToBounds,
//            contentMode: contentMode,
//            frame: frame,
//            isHidden: isHidden,
//            isMultipleTouchEnabled: isMultipleTouchEnabled,
//            isOpaque: isOpaque,
//            isUserInteractionEnabled: isUserInteractionEnabled,
//            tag: tag,
//            tintAdjustmentMode: tintAdjustmentMode,
//            tintColor: tintColor
//        )
//        
//        if let adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth {
//            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
//        }
//        
//        if let text = text {
//            self.text = text
//        }
//        
//        if let font = font {
//            self.font = font
//        }
//        
//        if let textColor = textColor {
//            self.textColor = textColor
//        }
//        
//        if let textAlignment = textAlignment {
//            self.textAlignment = textAlignment
//        }
//        
//        if let numberOfLines = numberOfLines {
//            self.numberOfLines = numberOfLines
//        }
//    }
//}
//
//#endif
