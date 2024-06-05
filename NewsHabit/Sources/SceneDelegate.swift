//
//  SceneDelegate.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // window 생성
        let newsHabitWindow = UIWindow(windowScene: windowScene)
        window = newsHabitWindow

        if UserDefaultsManager.isFirst {
            newsHabitWindow.rootViewController = UINavigationController(rootViewController: SetupProfileViewController())
        } else {
            newsHabitWindow.rootViewController = TabBarController()
        }
        
        newsHabitWindow.makeKeyAndVisible()
        
        // 앱의 테마 설정
        newsHabitWindow.overrideUserInterfaceStyle = newsHabitWindow.toUserInterfaceStyle(themeType: UserDefaultsManager.theme)
        
        // 알림 센터의 delegate 설정
        UNUserNotificationCenter.current().delegate = self
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        UserNotificationManager.shared.checkNotificationAuthorization { isAuthorized in
            // UserDefaults 값 업데이트
            UserDefaultsManager.isNotificationOn = isAuthorized
            
            // 사용자 로컬 알림 업데이트
            if isAuthorized {
                if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                    UserNotificationManager.shared.scheduleNotification(for: notificationTime)
                }
            } else {
                UserNotificationManager.shared.disableNotification()
            }
            
            // 알림 설정 뷰 UI 변경을 위한 메시지 발송
            NotificationCenter.default.post(name: .NotificationAuthorizationDidUpdate, object: nil)
        }
    }

}

extension SceneDelegate: UNUserNotificationCenterDelegate {
    
    // 알림 배너를 통해 앱에 진입했을 때 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        window?.rootViewController = TabBarController()
        completionHandler()
    }
    
    // 앱이 포그라운드 상태일 때 알림이 도착하면 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림 배너, 소리 등을 표시하도록 설정
        completionHandler([.banner, .badge, .list, .sound])
    }

}
