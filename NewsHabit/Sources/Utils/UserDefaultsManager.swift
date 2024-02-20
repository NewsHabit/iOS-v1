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

    @UserDefaultsData(key: UserDefaultsDataType.theme.rawValue, defaultValue: ThemeType.system.rawValue)
    static var theme: String

}

@propertyWrapper
struct UserDefaultsData<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
