import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}


protocol NavigationCoordinator: Coordinator {
    var nc: UINavigationController { get }
}
