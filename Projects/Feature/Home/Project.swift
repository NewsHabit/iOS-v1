//
//  Project.swift
//  HomeManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .feature(
        interface: .Home,
        factory: .init(
            dependencies: [
//                .domain
            ]
        )
    ),
    .feature(
        implements: .Home,
        factory: .init(
            dependencies: [
                .feature(interface: .Home)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Home,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Home)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Home.rawValue,
    targets: targets
)
