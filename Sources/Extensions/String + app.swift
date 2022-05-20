import Foundation

public extension String {
    
    static var appVersion: String? {
        guard let dictionary = Bundle.main.infoDictionary else {
            return nil
        }
        return dictionary["CFBundleShortVersionString"] as? String
    }
    
    static var appBuild: String? {
        guard let dictionary = Bundle.main.infoDictionary else {
            return nil
        }
        return dictionary["CFBundleVersion"] as? String
    }
    
    static var appBundleName: String {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError()
        }
        return dictionary["CFBundleName"] as! String
    }
    
 }
