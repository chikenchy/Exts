import Foundation

class Const {
    let groupId = "group.com.axi.MartCalculator"
}


extension NSNotification.Name {
    public static let HistorySettingChanged = NSNotification.Name("HistorySettingChanged")
}


var userSettingServiceSingleton = UserSettingService()
let coreDataServiceSingleton = CoreDataService()
let admobServiceSingleton = AdmobService()
let appRatingServiceSingleton = AppRatingService()
