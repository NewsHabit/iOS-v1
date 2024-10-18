//
//  Project.swift
//  DomainManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let domainTargets: [Target] = [
    .domain(
        factory: .init(
            dependencies: [
//                .core,
                .domain(implements: .News)
            ]
        )
    )
]

let domainProject: Project = .makeModule(
    name: ModulePath.Domain.name,
    targets: domainTargets
)
