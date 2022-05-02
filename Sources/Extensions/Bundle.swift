import Foundation

public extension Bundle {
    
    var appName: String { getInfo("CFBundleName")  }
    var displayName: String { getInfo("CFBundleDisplayName")}
    var developmentRegion: String { getInfo("CFBundleDevelopmentRegion")}
    var identifier: String { getInfo("CFBundleIdentifier")}
    var build: String { getInfo("CFBundleVersion") }
    var version: String { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String {
        if let str = infoDictionary?[str] as? String {
            return str
        } else {
            assert(false)
            return "⚠️"
        }
    }
}
