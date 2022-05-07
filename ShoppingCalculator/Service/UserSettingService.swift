import Foundation

let userSettingServiceSingleton = UserSettingService()

class UserSettingService: Codable {
    var currencyCode: String {
        get { userCurrencyCode ?? (Locale.current.currencyCode ?? "") }
    }
    var useDeviceCurrency: Bool = true
    var userCurrencyCode: String?
}


extension Locale {
    func currencySymbol(currencyCode: String) -> String? {
        return (self as NSLocale).displayName(forKey:NSLocale.Key.currencySymbol, value: currencyCode)
    }
}
