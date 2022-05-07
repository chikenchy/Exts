import Foundation

var userSettingServiceSingleton = UserSettingService()



class UserSettingService: Codable {
    var useDeviceCurrency: Bool = true
    var userCurrencyCode: String? = nil
    
    var currencyCode: String {
        get { userCurrencyCode ?? (Locale.current.currencyCode ?? "") }
    }
}

extension UserSettingService {
    
    class func loadFromUserDefault() -> UserSettingService? {
        guard let value = UserDefaults.standard.value(forKey: "UserSettings"),
              let data = value as? Data
        else {
            print("loadFromUserDefault UserDefaults failure")
            return nil
        }
        
        do {
            let userSettings = try PropertyListDecoder().decode(UserSettingService.self, from: data)
            return userSettings
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveToUserDefault() {
        do {
            let encoded = try PropertyListEncoder().encode(self)
            
            UserDefaults.standard.setValue(encoded, forKey: "UserSettings")
        } catch {
            print(error.localizedDescription)
        }
        
        
        if !UserDefaults.standard.synchronize() {
            print("saveToUserDefault synchronize failure")
        }
    }
}


extension Locale {
    func currencySymbol(currencyCode: String) -> String? {
        return (self as NSLocale).displayName(forKey:NSLocale.Key.currencySymbol, value: currencyCode)
    }
}
