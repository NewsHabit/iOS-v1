//
//  Project.swift
//  NetworkManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .core(
        interface: .Network,
        factory: .init(
            dependencies: [
                .shared
            ]
        )
    ),
    .core(
        implements: .Network,
        factory: .init(
            dependencies: [
                .core(interface: .Network)
            ]
        )
    ),
    .core(
        testing: .Network,
        factory: .init(
            dependencies: [
                .core(interface: .Network)
            ]
        )
    ),
    .core(
        tests: .Network,
        factory: .init(
            dependencies: [
                .core(implements: .Network),
                .core(testing: .Network)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Core.Network.rawValue,
    targets: targets
)

