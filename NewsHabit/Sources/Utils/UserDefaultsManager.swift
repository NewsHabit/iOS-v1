//
//  UserDefaultsManager.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Foundation

struct UserDefaultsManager {
    
    @UserDefaultsData(key: UserDefaultsDataType.username.rawValue, defaultValue: "뉴빗 사용자")
    static var username: String
    
    @UserDefaultsData(key: UserDefaultsDataType.keyword.rawValue, defaultValue: [KeywordType.itScience.rawValue])
    static var keyword: [Int]
    
    @UserDefaultsData(key: UserDefaultsDataType.todayNewsCount.rawValue, defaultValue: 3)
    static var todayNewsCount: Int

    @UserDefaultsData(key: UserDefaultsDataType.notification.rawValue, defaultValue: false)
    static var notification: Bool

    @UserDefaultsData(key: UserDefaultsDataType.theme.rawValue, defaultValue: ThemeType.system)
    static var theme: ThemeType
    
    @UserDefaultsData(key: UserDefaultsDataType.lastHotNewsUpdateTime.rawValue, defaultValue: "")
    static var lastHotNewsUpdateTime: String

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

