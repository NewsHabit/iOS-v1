//
//  Project.swift
//  FeatureManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let featureTargets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
//                .domain,
                .feature(implements: .Home),
                .feature(implements: .Onboarding),
                .feature(implements: .Settings)
            ]
        )
    )
]

let featurProject: Project = .makeModule(
    name: ModulePath.Feature.name,
    targets: featureTargets
)

