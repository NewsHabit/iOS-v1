//
//  Category.swift
//  SharedUtil
//
//  Created by 지연 on 10/20/24.
//

import Foundation

public enum Category: String, CaseIterable, Codable {
    case politics = "POLITICS"
    case economy = "ECONOMY"
    case society = "SOCIETY"
    case world = "WORLD"
    case lifestyleCulture = "LIFESTYLE_CULTURE"
    case itScience = "IT_SCIENCE"
    
    public var name: String {
        switch self {
        case .politics:         "정치"
        case .economy:          "경제"
        case .society:          "사회"
        case .world:            "세계"
        case .lifestyleCulture: "생활/문화"
        case .itScience:        "IT/과학"
        }
    }
}
