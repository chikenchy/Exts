import UIKit

public protocol CellReuseable {
    static var reuseIdentifier: String { get }
}

public extension CellReuseable where Self: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: Self.reuseIdentifier)
    }
    
    static func dequeueReusableCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Self.reuseIdentifier, for: indexPath) as? Self
    }
    
}

public extension CellReuseable where Self: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
    
    static func dequeueReusableCell(_ tableView: UITableView, indexPath: IndexPath) -> Self? {
        return tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath) as? Self
    }
    
}
