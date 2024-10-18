//
//  Project.swift
//  CoreManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let coreTargets: [Target] = [
    .core(
        factory: .init(
            dependencies: [
                .shared,
                .core(implements: .LocalStorage),
                .core(implements: .Network)
            ]
        )
    )
]

let coreProject: Project = .makeModule(
    name: ModulePath.Core.name,
    targets: coreTargets
)
