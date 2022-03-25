
import UIKit


class ModalMoveablePresentationController: UIPresentationController {
    private let modalMoveable: ModalMoveable
    
    
    init(
        modalMoveable: ModalMoveable,
        presentedViewController: UIViewController,
        presenting: UIViewController?
    ) {
        self.modalMoveable = modalMoveable
        super.init(presentedViewController: presentedViewController, presenting: presenting)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        
        return CGRect(
            x: 0,
            y: modalMoveable.defaultYPosition,
            width: bounds.width,
            height: bounds.height - modalMoveable.minYPosition
        )
    }
}
