//
//  AppDelegate.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 이번 달 기록 설정
        if UserDefaultsManager.lastMonth != Date().toMonthString() {
            UserDefaultsManager.lastMonth = Date().toMonthString()
            UserDefaultsManager.monthlyAllRead = []
        }
        return true
    }
    
}
