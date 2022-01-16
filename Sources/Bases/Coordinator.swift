import UIKit


protocol Coordinator {
    var childCoordinators: [Coodinator] { get }
    func start()
}


protocol NavigationCoordinator: Coordinator {
    var nc: UINavigationController { get }
}
