#if canImport(UIKit) && canImport(RxSwift)

import UIKit
import RxSwift

extension Exts.MVVM {
    open class VMViewController<VM: AnyObject>: UIViewController {
        var bag = DisposeBag()
        var vm: VM? {
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
        
        public func bind(to vm: VM) { }
    }
}

#endif
