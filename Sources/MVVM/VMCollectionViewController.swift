#if canImport(UIKit) && canImport(RxSwift) && canImport(SnapKit)

import UIKit
import RxSwift
import SnapKit

open class VMCollectionViewController<VM>: UIViewController, VMBindable {
    open var bag = DisposeBag()
    open private(set) var vm: VM?
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    open func bind(to vm: VM) {
        self.loadViewIfNeeded()
        self.vm = vm
        self.bag = DisposeBag()
    }
    
    public convenience init(to vm: VM) {
        self.init(nibName: nil, bundle: nil)
        self.bind(to: vm)
    }
    
}

#endif
