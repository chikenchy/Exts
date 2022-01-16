import UIKit


public protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}


public protocol NavigationCoordinator: Coordinator {
    var nc: UINavigationController { get }
}
