#if canImport(UIKit) && canImport(RxSwift)

import UIKit
import RxSwift

extension Exts.MVVM {
    
    open class VMTableViewCell<VM: AnyObject>: UITableViewCell {
        var bag = DisposeBag()
        var vm: VM? {
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
    
}

#endif
