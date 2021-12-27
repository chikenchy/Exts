
import UIKit
import RxSwift

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
    
    convenience init(to vm: VM) {
        self.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
    func bind(to vm: VM) { }
}
