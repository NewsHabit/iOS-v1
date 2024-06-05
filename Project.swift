import ProjectDescription

let infoPlist: [String: Plist.Value] = [
    "ITSAppUsesNonExemptEncryption": .boolean(false),
    "CFBundleDisplayName": .string("뉴빗"),
    "CFBundleName": .string("NewsHabit"),
    "CFBundleShortVersionString": .string("1.0.3"),
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
]

// MARK: - Project

let project: Project = .init(
    name: "NewsHabit",
    packages: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMinor(from: "5.0.1")),
        .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [Target(
        name: "NewsHabit",
        destinations: [.iPhone],
        product: .app,
        bundleId: "com.NewsHabit",
        deploymentTargets: .iOS("15.0"),
        infoPlist: .extendingDefault(with: infoPlist),
        sources: ["NewsHabit/Sources/**"],
        resources: "NewsHabit/Resources/**",
        dependencies: [
            .package(product: "Alamofire"),
            .package(product: "Kingfisher"),
            .package(product: "SnapKit"),
            .package(product: "Then")
        ]
    )]
)
