//
//  UserDefaultsManager.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Foundation

struct UserDefaultsManager {
    
    @UserDefaultsData(key: "username", defaultValue: "사용자")
    static var username: String
    
    @UserDefaultsData(key: "cagetoryList", defaultValue: Category.allCases.map { $0.rawValue })
    static var categoryList: [Int]
    
    @UserDefaultsData(key: "todayNewsCount", defaultValue: TodayNewsCountType.three)
    static var todayNewsCount: TodayNewsCountType

    @UserDefaultsData(key: "isNotificationOn", defaultValue: false)
    static var isNotificationOn: Bool
    
    @UserDefaultsData(key: "notificationTime", defaultValue: "09:00 AM")
    static var notificationTime: String

    @UserDefaultsData(key: "theme", defaultValue: ThemeType.system)
    static var theme: ThemeType
    
    @UserDefaultsData(key: "todayNews", defaultValue: [])
    static var todayNews: [TodayNewsItemState]
    
    @UserDefaultsData(key: "numOfDaysAllRead", defaultValue: 0)
    static var numOfDaysAllRead: Int
    
    @UserDefaultsData(key: "lastDate", defaultValue: "")
    static var lastDate: String
    
    @UserDefaultsData(key: "lastMonth", defaultValue: "")
    static var lastMonth: String
    
    @UserDefaultsData(key: "daysAllRead", defaultValue: [])
    static var daysAllRead: [String]

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

