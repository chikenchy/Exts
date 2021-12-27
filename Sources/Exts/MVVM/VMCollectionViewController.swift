#if canImport(UIKit) && canImport(RxSwift) && canImport(SnapKit)

import UIKit
import RxSwift
import SnapKit

open class VMCollectionViewController<VM: AnyObject>: UIViewController {
    open var bag = DisposeBag()
    open var vm: VM? {
        didSet {
            self.bag = DisposeBag()
            if let vm = self.vm,
               self.isViewLoaded {
                self.bind(to: vm)
            }
        }
    }
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    open func bind(to vm: VM) { }
    
    public convenience init(to vm: VM) {
        self.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
}

#endif
