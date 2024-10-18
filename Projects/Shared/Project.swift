//
//  Project.swift
//  SharedManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let sharedTargets: [Target] = [
    .shared(
        factory: .init(
            dependencies: [
                .shared(implements: .DesignSystem),
                .shared(implements: .Util)
            ]
        )
    )
]

let sharedProject: Project = .makeModule(
    name: ModulePath.Shared.name,
    targets: sharedTargets
)
