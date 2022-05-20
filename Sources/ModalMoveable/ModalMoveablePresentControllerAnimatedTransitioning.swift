import UIKit

final class ModalMoveablePresentControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let modalMoveable: ModalMoveable
    
    
    init(modalMoveable: ModalMoveable) {
        self.modalMoveable = modalMoveable
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return modalMoveable.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        else { return }
        
        let containerView = transitionContext.containerView
        
        if let backdropView = modalMoveable.backdropView {
            backdropView.backgroundColor = .clear
            backdropView.frame = containerView.frame
            containerView.addSubview(backdropView)
        }
        containerView.addSubview(toVC.view)
        
        // toVC.view가 frameOfPresentedViewInContainerView 사이즈가 아닌 화면사이즈로 설정되어 있기 때문에, 수동으로 사이즈를 변경
        toVC.view.frame = .init(
            origin: .init(
                x: 0,
                y: UIScreen.main.bounds.height
            ),
            size: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height - modalMoveable.minYPosition
            )
        )
        
        UIView.animate(
            withDuration: modalMoveable.transitionDuration,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                toVC.view.frame.origin.y -= (UIScreen.main.bounds.height - self.modalMoveable.defaultYPosition)
                self.modalMoveable.backdropView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            },
            completion: { finished in
                transitionContext.completeTransition(true)
            }
        )
    }
    
}

