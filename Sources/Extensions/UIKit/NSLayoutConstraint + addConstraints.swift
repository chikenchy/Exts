import UIKit

extension NSLayoutConstraint {
    
    open class func constraints(
        visualFormat: String,
        views: UIView...
    ) -> [NSLayoutConstraint] {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary)
    }
    
}
