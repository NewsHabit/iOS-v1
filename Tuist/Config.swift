//
//  Config.swift
//  Config
//
//  Created by 지연 on 10/19/24.
//

import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/EnvironmentPlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ]
)
