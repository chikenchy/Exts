#if canImport(UIKit) && canImport(RxSwift)

import UIKit
import RxSwift


extension Exts.MVVM {
    open class VMTableViewController<VM: AnyObject>: UIViewController {
        public var bag = DisposeBag()
        public var vm: VM? {
            didSet {
                self.bag = DisposeBag()
                if let vm = self.vm,
                   self.isViewLoaded {
                    self.bind(to: vm)
                }
            }
        }
        public let tableView = UITableView(frame: .zero, style: .plain)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(self.tableView)
            self.tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        
        public func bind(to vm: VM) { }
        
        public convenience init(to vm: VM) {
            self.init(nibName: nil, bundle: nil)
            self.vm = vm
        }
        
    }
}

#endif
