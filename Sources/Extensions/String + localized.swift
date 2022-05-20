import Foundation

public extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
