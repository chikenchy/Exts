#if canImport(UIKit)
import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}


public protocol NavigationCoordinator: Coordinator {
    var nc: UINavigationController { get }
}

public class AppsCoordinator: NavigationCoordinator {
    
    let window: UIWindow
    var childCoordinators = [Coordinator]()
    var nc: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        window.rootViewController = SampleListVC(to: SampleListVM()).addNC()
    }
}

#endif
