//
//  Project.swift
//  OnboardingManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .feature(
        interface: .Onboarding,
        factory: .init(
            dependencies: [
//                .domain
            ]
        )
    ),
    .feature(
        implements: .Onboarding,
        factory: .init(
            dependencies: [
                .feature(interface: .Onboarding)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Onboarding,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Onboarding)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Onboarding.rawValue,
    targets: targets
)
