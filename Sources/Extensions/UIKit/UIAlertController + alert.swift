import UIKit

extension UIAlertController {
    
    open class func alert(
        title: String?,
        message: String?,
        cancel: String?,
        okAction: UIAlertAction?
    ) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancel != nil {
            ac.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        }
        if let okAction = okAction {
            ac.addAction(okAction)
        }
        return ac
    }
    
}
