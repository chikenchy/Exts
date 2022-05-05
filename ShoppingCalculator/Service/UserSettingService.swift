import Foundation

let userSettingServiceSingleton = UserSettingService()

class UserSettingService: Codable {
    var currencyCode: String {
        get { userCurrencyCode ?? (Locale.current.currencyCode ?? "") }
    }
    
    var userCurrencyCode: String?
}
