import Foundation
import RxSwift

public protocol VMBindable {
    associatedtype VM
    
    var bag: DisposeBag { get }
    var vm: VM? { get }
    func bind(to vm: VM)
}
