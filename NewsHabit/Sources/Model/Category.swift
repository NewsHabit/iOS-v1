//
//  Category.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Foundation

enum Category: Int, CaseIterable {
    
    case politics
    case economy
    case society
    case world
    case lifestyleCulture
    case itScience
    
    func toString() -> String {
        switch self {
        case .politics: "정치"
        case .economy: "경제"
        case .society: "사회"
        case .world: "세계"
        case .lifestyleCulture: "생활/문화"
        case .itScience: "IT/과학"
        }
    }
    
    func toAPIString() -> String {
        switch self {
        case .politics: "POLITICS"
        case .economy: "ECONOMY"
        case .society: "SOCIETY"
        case .world: "WORLD"
        case .lifestyleCulture: "LIFESTYLE_CULTURE"
        case .itScience: "IT_SCIENCE"
        }
    }
    
    static func fromAPIString(_ apiString: String) -> String? {
        guard let category = Category.allCases.first(where: { $0.toAPIString() == apiString })
        else { return nil }
        return category.toString()
    }
    
}
