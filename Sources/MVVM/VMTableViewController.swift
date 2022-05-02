#if canImport(UIKit) && canImport(RxSwift) && canImport(SnapKit)

import UIKit
import RxSwift

open class VMTableViewController<VM>: UIViewController, VMBindable {
    open var bag = DisposeBag()
    open private(set) var vm: VM?
    public let tableView = UITableView(frame: .zero, style: .plain)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
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
