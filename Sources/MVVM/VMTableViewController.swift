#if canImport(UIKit) && canImport(RxSwift) && canImport(SnapKit)

import UIKit
import RxSwift

open class VMTableViewController<VM>: UITableViewController, VMBindable {
    open var bag = DisposeBag()
    open private(set) var vm: VM?
    
    open func bind(to vm: VM) {
        self.loadViewIfNeeded()
        self.vm = vm
        self.bag = DisposeBag()
    }
    
    public convenience init(to vm: VM) {
        self.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
}
#endif
