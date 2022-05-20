import UIKit

public extension UIViewController {
    
    static func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.rootViewController?.topMostViewController()
        } else {
            return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
        }
    }
    
    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        } else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        } else {
            return self
        }
    }
    
}
