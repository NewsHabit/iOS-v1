//
//  AppDelegate.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 이번 달 기록 설정
        if UserDefaultsManager.lastMonth != Date().toMonthString() {
            UserDefaultsManager.lastMonth = Date().toMonthString()
            UserDefaultsManager.monthlyAllRead = []
        }
        // 알림 센터의 delegate 설정
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 앱이 포그라운드 상태일 때 알림이 도착하면 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림 배너, 소리 등을 표시하도록 설정
        completionHandler([.banner, .badge, .list, .sound])
    }
    
}
