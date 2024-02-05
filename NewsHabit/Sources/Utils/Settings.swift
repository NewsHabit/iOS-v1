//
//  Settings.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import Foundation

enum SettingsType: String {
    case username
    case keyword
    case todayNewsCount
    case notification
    case theme
}

struct Settings {
    
    @UserDefaultsWrapper(key: SettingsType.username.rawValue, defaultValue: "뉴빗 사용자")
    static var username: String
    
    @UserDefaultsWrapper(key: SettingsType.keyword.rawValue, defaultValue: "기본키워드")
    static var keyword: String
    
    @UserDefaultsWrapper(key: SettingsType.todayNewsCount.rawValue, defaultValue: 3)
    static var todayNewsCount: Int

    @UserDefaultsWrapper(key: SettingsType.notification.rawValue, defaultValue: false)
    static var notification: Bool

    @UserDefaultsWrapper(key: SettingsType.theme.rawValue, defaultValue: "기본테마")
    static var theme: String

}

@propertyWrapper
struct UserDefaultsWrapper<Value> {
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
