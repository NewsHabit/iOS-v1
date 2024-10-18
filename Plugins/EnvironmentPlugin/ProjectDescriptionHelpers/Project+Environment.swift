//
//  Project+Environment.swift
//  EnvironmentPlugin
//
//  Created by 지연 on 10/19/24.
//

import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "newshabit"
        public static let deploymentTargets = DeploymentTargets.iOS("17.0")
        public static let bundleId = "com.goojiong.newshabit"
        public static let defaultSettings: Settings = .settings(
            base: [
                "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
            ]
        )
        public static let appSettings: Settings = .settings(
            base: [
                "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
            ],
            configurations: [
                .debug(name: "Debug", xcconfig: "Configurations/secrets.xcconfig"),
                .release(name: "Release", xcconfig: "Configurations/secrets.xcconfig")
            ]
        )
        public static let appInfoPlist: InfoPlist = .extendingDefault(with: [
            "ITSAppUsesNonExemptEncryption": false,
            "CFBundleDisplayName": "뉴빗",
            "CFBundleName": "newshabit",
            "CFBundleShortVersionString": "2.0.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen",
            "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [[
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ]]
                ]
            ]
        ])
    }
}
