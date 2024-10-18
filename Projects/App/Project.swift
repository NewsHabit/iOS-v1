//
//  Project.swift
//  AppManifests
//
//  Created by 지연 on 10/19/24.
//

import EnvironmentPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let appTargets: [Target] = [
    .app(
        implements: .iOS,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            settings: Project.Environment.appSettings
        )
    )
]

let appProject: Project = .makeModule(
    name: Project.Environment.appName,
    targets: appTargets
)
