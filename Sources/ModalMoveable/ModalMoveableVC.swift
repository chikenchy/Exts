
import UIKit
import Exts

public protocol ModalMoveable: UIViewController {
    var backdropView: UIView? { get }
    var defaultYPosition: CGFloat { get }
    var dismissYPosition: CGFloat { get }
    var minYPosition: CGFloat { get }
    var transitionDuration: TimeInterval { get }
}


open class ModalMoveableVC: UIViewController, ModalMoveable {
    var backgroundView = UIView()
    private var locationOfPanBegan: CGPoint?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.cornerRadius(
            radius: 10,
            rectCorner: [.topLeft, .topRight]
        )
        
        // set backdropView tapping
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onTappedBackdropView(_:))
        )
        backgroundView.addGestureRecognizer(tapGesture)
        
        // set view panning
        let panGesuture = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(_:)))
        self.view.addGestureRecognizer(panGesuture)
    }
    
    @objc private func onTappedBackdropView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let isDraggingDown = velocity.y > 0.0
        
        switch sender.state {
        case .began:
            locationOfPanBegan = location
        case .changed:
            guard let locationOfPanBegan = locationOfPanBegan else { return }
            
            let newOroginY = max(self.minYPosition, self.view.frame.origin.y + location.y - locationOfPanBegan.y)
            self.view.frame.origin.y = newOroginY
        case .ended:
            let currentOriginY = self.view.frame.origin.y
            if isDraggingDown {
                if currentOriginY < minYPosition {
                    animateMove(minYPosition)
                } else if currentOriginY < defaultYPosition {
                    animateMove(defaultYPosition)
                } else if currentOriginY < dismissYPosition {
                    animateMove(defaultYPosition)
                } else {
                    dismiss(animated: true, completion: nil)
                }
            } else {
                if currentOriginY < minYPosition {
                    animateMove(minYPosition)
                } else if currentOriginY < defaultYPosition {
                    animateMove(minYPosition)
                } else {
                    animateMove(defaultYPosition)
                }
            }
        default:
            break
        }
    }
    
    private func animateMove(_ yPosition: CGFloat) {
        let animator =  UIViewPropertyAnimator(
            duration: 1.0,
            dampingRatio: 1.0
        ) { [weak self] in
            guard let self = self else { return }
            
            self.view.frame.origin.y = yPosition
            self.view.superview?.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
    
    // MARK: ModalMoveable
    
    open var backdropView: UIView? { self.backgroundView }
    
    open var dismissYPosition: CGFloat { UIScreen.main.bounds.height * 4 / 5 }
    
    open var defaultYPosition: CGFloat { UIScreen.main.bounds.height / 2 }
    
    open var minYPosition: CGFloat { UIScreen.main.bounds.height / 6 }
    
    open var transitionDuration: TimeInterval { 0.4 }
}


extension ModalMoveableVC: UIViewControllerTransitioningDelegate {
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let modalMoveable = presented as? ModalMoveable else { return nil }
        
        return ModalMoveablePresentControllerAnimatedTransitioning(modalMoveable: modalMoveable)
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let modalMoveable = dismissed as? ModalMoveable else { return nil }
        
        return ModalMoveableDismissControllerAnimatedTransitioning(modalMoveable: modalMoveable)
    }
    
    // TODO: backdropView를 어디서 추가해야하는지 몰라서 주석화
    // 상속 클래스에서 animationController(forPresented:) 함수를 override하여 nil을 반환할 때도 self.view의 포지션과 크기를 default로 설정하기 위해 이 함수가 사용됨
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        guard let modalMoveable = presented as? ModalMoveable else { return nil }
//
//        return ModalMoveablePresentationController(
//            modalMoveable: modalMoveable,
//            presentedViewController: presented,
//            presenting: presenting
//        )
//    }
}
