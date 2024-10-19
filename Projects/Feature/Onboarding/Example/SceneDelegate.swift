//
//  SceneDelegate.swift
//  FeatureOnboardingExample
//
//  Created by 지연 on 10/19/24.
//

import UIKit

import FeatureOnboarding

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
            rootViewController: CategoryViewController()
        )
        window?.makeKeyAndVisible()
    }
}
