//
//  SceneDelegate.swift
//  FeatureSettingsExample
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import FeatureSettings

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(
            rootViewController: NotificationViewController()
        )
        window?.makeKeyAndVisible()
    }
}
