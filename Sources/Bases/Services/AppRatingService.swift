import UIKit
import SwiftRater

open class AppRatingService {
    public struct Configuration {
        var daysUntilPrompt: Int
        var usesUntilPrompt: Int
        var significantUsesUntilPrompt: Int
        var daysBeforeReminding: Int
        var showLaterButton: Bool
        var debugMode: Bool
        
        public init(
            daysUntilPrompt: Int,
            usesUntilPrompt: Int,
            significantUsesUntilPrompt: Int,
            daysBeforeReminding: Int,
            showLaterButton: Bool,
            debugMode: Bool
        ) {
            self.daysUntilPrompt = daysUntilPrompt
            self.usesUntilPrompt = usesUntilPrompt
            self.significantUsesUntilPrompt = significantUsesUntilPrompt
            self.daysBeforeReminding = daysBeforeReminding
            self.showLaterButton = showLaterButton
            self.debugMode = debugMode
        }
    }
    
    public init() { }
    
    public func setup(_ configuration: AppRatingService.Configuration) {
        SwiftRater.daysUntilPrompt = configuration.daysUntilPrompt
        SwiftRater.usesUntilPrompt = configuration.usesUntilPrompt
        SwiftRater.significantUsesUntilPrompt = configuration.significantUsesUntilPrompt
        SwiftRater.daysBeforeReminding = configuration.daysBeforeReminding
        SwiftRater.showLaterButton = configuration.showLaterButton
        SwiftRater.debugMode = configuration.debugMode
        
        SwiftRater.appLaunched()
    }
    
    @discardableResult
    public func check(host: UIViewController? = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first(where: { $0 is UIWindowScene }).flatMap({ $0 as? UIWindowScene })?.windows.first(where: \.isKeyWindow)?.rootViewController) -> Bool {
        return SwiftRater.check(host: host)
    }
    
    public func incrementSignificantUsageCount() {
        SwiftRater.incrementSignificantUsageCount()
    }
    
}
