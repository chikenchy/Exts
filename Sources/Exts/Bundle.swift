import Foundation

extension Bundle {
    
    public var appName: String { getInfo("CFBundleName")  }
    public var displayName: String { getInfo("CFBundleDisplayName")}
    public var developmentRegion: String { getInfo("CFBundleDevelopmentRegion")}
    public var identifier: String { getInfo("CFBundleIdentifier")}
    public var build: String { getInfo("CFBundleVersion") }
    public var version: String { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String {
        if let str = infoDictionary?[str] as? String {
            return str
        } else {
            assert(false)
            return "⚠️"
        }
    }
}
