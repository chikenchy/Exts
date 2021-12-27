#if canImport(UIKit) && canImport(RxSwift)

import UIKit
import RxSwift

extension Exts.MVVM {
    
    public class VMCollectionViewController<VM: AnyObject>: UIViewController {
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(self.collectionView)
            self.collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        
        func bind(to vm: VM) { }
        
        convenience init(to vm: VM) {
            self.init(nibName: nil, bundle: nil)
            self.vm = vm
        }
        
    }
    
}

#endif
