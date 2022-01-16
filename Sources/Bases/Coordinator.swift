import UIKit


protocol Coodinator {
    var childCoordinators: [Coodinator] { get }
    func start()
}


protocol NavigationCoordinator: Coodinator {
    var nc: UINavigationController { get }
}
