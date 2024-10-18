//
//  Project.swift
//  SettingsManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .feature(
        interface: .Settings,
        factory: .init(
            dependencies: [
//                .domain
            ]
        )
    ),
    .feature(
        implements: .Settings,
        factory: .init(
            dependencies: [
                .feature(interface: .Settings)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Settings,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Settings)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Settings.rawValue,
    targets: targets
)
