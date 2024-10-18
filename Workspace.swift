//
//  Workspace.swift
//  AppManifests
//
//  Created by 지연 on 10/19/24.
//

import EnvironmentPlugin
import ProjectDescription

let workspace = Workspace(
    name: Project.Environment.appName,
    projects: ["Projects/*"]
)
