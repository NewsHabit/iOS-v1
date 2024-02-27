//
//  UserDefaultsManager.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Foundation

struct UserDefaultsManager {
    
    @UserDefaultsData(key: "username", defaultValue: "뉴빗 사용자")
    static var username: String
    
    @UserDefaultsData(key: "keywordList", defaultValue: [KeywordType.itScience.rawValue])
    static var keywordList: [Int]
    
    @UserDefaultsData(key: "todayNewsCount", defaultValue: 3)
    static var todayNewsCount: Int

    @UserDefaultsData(key: "isNotificationOn", defaultValue: false)
    static var isNotificationOn: Bool
    
    @UserDefaultsData(key: "notificationTime", defaultValue: "09:00 AM")
    static var notificationTime: String

    @UserDefaultsData(key: "theme", defaultValue: ThemeType.system)
    static var theme: ThemeType
    
    @UserDefaultsData(key: "todayNews", defaultValue: [])
    static var todayNews: [TodayNewsItemState]
    
    @UserDefaultsData(key: "daysAllRead", defaultValue: 0)
    static var daysAllRead: Int
    
    @UserDefaultsData(key: "lastDate", defaultValue: "")
    static var lastDate: String

}

import Foundation

@propertyWrapper
struct UserDefaultsData<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            guard let data = container.object(forKey: key) as? Data else {
                return defaultValue
            }
            do {
                let value = try JSONDecoder().decode(Value.self, from: data)
                return value
            } catch {
                print("Error decoding UserDefaults data for key \(key): \(error)")
                return defaultValue
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                container.set(data, forKey: key)
            } catch {
                print("Error encoding UserDefaults data for key \(key): \(error)")
            }
        }
    }
}

