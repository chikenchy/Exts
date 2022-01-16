import UIKit


public protocol Coodinator {
    var childCoordinators: [Coodinator] { get }
    func start()
}


public protocol NavigationCoordinator: Coodinator {
    var nc: UINavigationController { get }
}
