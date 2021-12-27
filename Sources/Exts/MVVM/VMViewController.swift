
import UIKit
import RxSwift

open class VMViewController<VM: AnyObject>: UIViewController {
    open var bag = DisposeBag()
    open var vm: VM? {
        didSet {
            self.bag = DisposeBag()
            if let vm = self.vm,
               self.isViewLoaded {
                self.bind(to: vm)
            }
        }
    }
    
    public convenience init(to vm: VM) {
        self.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
    open func bind(to vm: VM) { }
}
