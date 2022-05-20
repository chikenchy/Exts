import UIKit

public extension UITableView {
    
    func register(cellClasses: [AnyClass]) {
        for cellClass in cellClasses {
            let identifier = cellClass.description()
            print(identifier)
            self.register(cellClass, forCellReuseIdentifier: identifier)
        }
    }
    
    func register(nibLoadableTypes: [NibLoadable.Type]) {
        for type in nibLoadableTypes {
            let identifier = String(describing: type)
            print(identifier)
            self.register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        print(identifier)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    //   func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T : NibLoadable {
    //        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    //    }
    
    func dequeueReusableHeaderFooterView<T>() -> T? where T: UITableViewHeaderFooterView {
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
    }
    
}

