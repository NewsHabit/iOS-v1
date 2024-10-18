//
//  ProjectDescriptionPath+Modules.swift
//  DependencyPlugin
//
//  Created by 지연 on 10/19/24.
//

import ProjectDescription

// MARK: - App

public extension ProjectDescription.Path {
    static var app: Self {
        return .relativeToRoot("Projects/\(ModulePath.App.name)")
    }
}

// MARK: - Feature

public extension ProjectDescription.Path {
    static var feature: Self {
        return .relativeToRoot("Projects/\(ModulePath.Feature.name)")
    }
    
    static func feature(implementation module: ModulePath.Feature) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Feature.name)/\(module.rawValue)")
    }
}

// MARK: - Domain

public extension ProjectDescription.Path {
    static var domain: Self {
        return .relativeToRoot("Projects/\(ModulePath.Domain.name)")
    }

    static func domain(implementation module: ModulePath.Domain) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Domain.name)/\(module.rawValue)")
    }
}

// MARK: - Core

public extension ProjectDescription.Path {
    static var core: Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)")
    }
    
    static func core(implementation module: ModulePath.Core) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)/\(module.rawValue)")
    }
}

// MARK: - Shared

public extension ProjectDescription.Path {
    static var shared: Self {
        return .relativeToRoot("Projects/\(ModulePath.Shared.name)")
    }

    static func shared(implementation module: ModulePath.Shared) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Shared.name)/\(module.rawValue)")
    }
}
