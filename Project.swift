import ProjectDescription

// MARK: - ProjectFactory Protocol

protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
}

// MARK: - NewsHabitFactory

class NewsHabitFactory: ProjectFactory {
    
    let projectName: String = "NewsHabit"
    
    let bundleId: String = "Green-Tea-organization-NewsHabit"
    
    let dependencies: [TargetDependency] = []
    
    let infoPlist: [String: Plist.Value] = [
        "ITSAppUsesNonExemptEncryption": .boolean(false),
        "CFBundleName": .string("NewsHabit"),
        "CFBundleShortVersionString": .string("1.2.1"),
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
        ])
    ]
    
    func generateTarget() -> [ProjectDescription.Target] {[
        Target(
            name: projectName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(projectName)/Sources/**"],
            resources: "\(projectName)/Resources/**",
            dependencies: dependencies
        )
    ]}
}

// MARK: - Project

let factory = NewsHabitFactory()

let project: Project = .init(
    name: factory.projectName,
    targets: factory.generateTarget()
)
