//
//  Project.swift
//  NewsManifests
//
//  Created by 지연 on 10/19/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .domain(
        interface: .News,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .News,
        factory: .init(
            dependencies: [
                .domain(interface: .News)
            ]
        )
    ),
    .domain(
        testing: .News,
        factory: .init(
            dependencies: [
                .domain(interface: .News)
            ]
        )
    ),
    .domain(
        tests: .News,
        factory: .init(
            dependencies: [
                .domain(implements: .News),
                .domain(testing: .News)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Domain.News.rawValue,
    targets: targets
)
