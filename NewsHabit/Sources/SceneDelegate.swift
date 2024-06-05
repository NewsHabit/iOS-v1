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
        let myWindow = UIWindow(windowScene: windowScene)
        
        // 알림 센터의 delegate 설정
        UNUserNotificationCenter.current().delegate = self
        
        // 앱의 테마 설정
        myWindow.overrideUserInterfaceStyle = myWindow.toUserInterfaceStyle(themeType: UserDefaultsManager.theme)
        
        // 루트 뷰 컨트롤러 설정
        if UserDefaultsManager.isFirst {
            myWindow.rootViewController = UINavigationController(rootViewController: SetupProfileViewController())
        } else {
            myWindow.rootViewController = TabBarController()
        }
        
        window = myWindow
        myWindow.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        // 이번 달 기록 설정
        if UserDefaultsManager.lastMonth != Date().toMonthString() {
            UserDefaultsManager.lastMonth = Date().toMonthString()
            UserDefaultsManager.monthlyAllRead = []
        }
        // 알림 권한 체크
        UserNotificationManager.shared.checkNotificationAuthorization { isAuthorized in
            UserDefaultsManager.isNotificationOn = isAuthorized
            if isAuthorized {
                if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                    UserNotificationManager.shared.addNotification(for: notificationTime)
                }
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
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
