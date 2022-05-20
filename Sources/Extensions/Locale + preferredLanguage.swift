import Foundation

public extension Locale {
    
    static var preferredLanguage: Self {
        Locale(identifier: Locale.preferredLanguages.first!)
    }
    
}
