#if canImport(UIKit) && canImport(RxSwift)

import UIKit
import RxSwift

open class VMTableViewCell<VM: AnyObject>: UITableViewCell {
    public var bag = DisposeBag()
    public var vm: VM? {
        didSet {
            self.bag = DisposeBag()
            if let vm = self.vm {
                self.bind(to: vm)
            }
        }
    }
    
    open func bind(to vm: VM) {
        
    }
}


#endif