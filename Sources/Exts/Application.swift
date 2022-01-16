import UIKit

extension UIApplication {
    
    static func isVersionRequired(min: String) -> Bool {
        return Bundle.main.version.compare(min, options: .numeric) != .orderedAscending
    }
    
    static func isBuildRequired(min: String) -> Bool {
        return Bundle.main.build.compare(min, options: .numeric) != .orderedAscending
    }
}
