import UIKit

class ModalMoveableDismissControllerAnimatedTransitioning : NSObject, UIViewControllerAnimatedTransitioning {
    private let modalMoveable: ModalMoveable
    
    
    init(modalMoveable: ModalMoveable) {
        self.modalMoveable = modalMoveable
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return modalMoveable.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        else { return }
        
        UIView.animate(
            withDuration: modalMoveable.transitionDuration,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                fromVC.view.frame.origin.y += self.modalMoveable.view.frame.height
                self.modalMoveable.backdropView?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            },
            completion: { finished in
                self.modalMoveable.backdropView?.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
    }
    
}
