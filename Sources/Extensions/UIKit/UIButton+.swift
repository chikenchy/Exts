#if canImport(UIKit)

import UIKit

extension UIButton {
    
    public func setImages(_ array: [(UIControl.State, UIImage?)]) {
        array.forEach { (state: UIControl.State, image: UIImage?) in
            self.setImage(image, for: state)
        }
    }
    
}

#endif
