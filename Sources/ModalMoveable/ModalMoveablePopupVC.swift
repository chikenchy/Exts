
import UIKit
import RxSwift


final class ModalMoveablePopupVC: ModalMoveableVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = .yellow
    }
    
    override var minYPosition: CGFloat { 0 }
    override var dismissYPosition: CGFloat { UIScreen.main.bounds.maxY }
}
