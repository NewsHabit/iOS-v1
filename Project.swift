import ProjectDescription

let infoPlist: [String: Plist.Value] = [
    "ITSAppUsesNonExemptEncryption": .boolean(false),
    "CFBundleDisplayName": .string("뉴빗"),
    "CFBundleName": .string("newsHabit"),
    "CFBundleShortVersionString": .string("2.0.0"),
    "CFBundleVersion": .string("1"),
    "UILaunchStoryboardName": .string("LaunchScreen"),
    "UIApplicationSceneManifest": .dictionary([
        "UIApplicationSupportsMultipleScenes": .boolean(false),
        "UISceneConfigurations": .dictionary([
            "UIWindowSceneSessionRoleApplication": .array([
                .dictionary([
                    "UISceneConfigurationName": .string("Default Configuration"),
                    "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                ])
            ])
        ])
    ]),
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
]

let project = Project(
    name: "newshabit",
    targets: [
        .target(
            name: "newshabit",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.goojiong.newshabit",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["newshabit/Sources/**"],
            resources: ["newshabit/Resources/**"],
            dependencies: []
        )
    ]
)
