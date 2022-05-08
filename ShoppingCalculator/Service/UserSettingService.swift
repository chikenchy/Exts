import Foundation

var userSettingServiceSingleton = UserSettingService()


enum HistorySortColumn: String, Codable, Equatable, CustomStringConvertible {
    case createdAt
    case updatedAt
    
    var description: String {
        switch self {
        case .createdAt:
            return NSLocalizedString("CreatedDate", comment: "")
        case .updatedAt:
            return NSLocalizedString("UpdateDate", comment: "")
        }
    }
}

enum HistorySortOrder: Int, Codable, Equatable, CustomStringConvertible {
    case acs
    case desc
    
    var description: String {
        switch self {
        case .acs:
            return "오름차순"
        case .desc:
            return "내림차순"
        }
    }
}

struct UserSetting: Codable {
    var useDeviceCurrency: Bool = true
    var userCurrencyCode: String? = nil
    var sortColumn: HistorySortColumn = .createdAt
    var sortOrder: HistorySortOrder = .acs
}

final class UserSettingService {
    var userSetting = UserSetting()
    
    var currencyCode: String {
        get { userSetting.userCurrencyCode ?? (Locale.current.currencyCode ?? "") }
    }
    
    func loadFromUserDefault() {
        guard let value = UserDefaults.standard.value(forKey: "UserSettings"),
              let data = value as? Data
        else {
            print("loadFromUserDefault UserDefaults failure")
            return
        }
        
        do {
            let userSetting = try PropertyListDecoder().decode(UserSetting.self, from: data)
            self.userSetting = userSetting
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveToUserDefault() {
        do {
            let encoded = try PropertyListEncoder().encode(userSetting)
            
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
