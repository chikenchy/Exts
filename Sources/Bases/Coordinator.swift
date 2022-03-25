#if canImport(UIKit)
import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}


public protocol NavigationCoordinator: Coordinator {
    var nc: UINavigationController { get }
}

//public class AppsCoordinator: NavigationCoordinator {
//    let window: UIWindow
//    public var childCoordinators = [Coordinator]()
//    public var nc: UINavigationController
//    
//    init(window: UIWindow) {
//        self.window = window
//        self.nc = UINavigationController()
//    }
//    
//    public func start() {
//    }
//}

#endif
