import UIKit
import RxSwift

open class VMCollectionViewCell<VM>: UICollectionViewCell, VMBindable {
    open var bag = DisposeBag()
    open private(set) var vm: VM?
    
    open func bind(to vm: VM) {
        self.vm = vm
        self.bag = DisposeBag()
    }
    
}
