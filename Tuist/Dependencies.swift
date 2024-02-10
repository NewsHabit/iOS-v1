import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.1")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
