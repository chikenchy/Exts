
import UIKit
import RxSwift

open class VMViewController<VM>: UIViewController, VMBindable {
    open var bag = DisposeBag()
    open private(set) var vm: VM?
    
    public convenience init(to vm: VM) {
        self.init(nibName: nil, bundle: nil)
        self.bind(to: vm)
    }
    
    open func bind(to vm: VM) {
        self.loadViewIfNeeded()
        self.vm = vm
        self.bag = DisposeBag()
    }
}
