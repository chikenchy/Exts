import UIKit
import RxSwift

public class VMView<VM>: UIView, VMBindable {
    public var bag = DisposeBag()
    open private(set) var vm: VM?
    
    public func bind(to vm: VM) {
        self.bag = DisposeBag()
        self.vm = vm
    }
    
}
