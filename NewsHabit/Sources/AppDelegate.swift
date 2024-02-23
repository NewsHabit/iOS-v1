//
//  AppDelegate.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 알림 센터의 delegate 설정
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // 앱이 포그라운드 상태일 때 알림이 도착하면 호출됩니다.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림 배너, 소리 등을 표시하도록 설정
        completionHandler([.banner, .badge, .list, .sound])
    }
}

