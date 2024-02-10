//
//  Keyword.swift
//  NewsHabit
//
//  Created by jiyeon on 2/8/24.
//

import Foundation

enum Keyword: Int, CaseIterable {
    case politics
    case economy
    case society
    case world
    case lifestyleCulture
    case itScience
    
    func toString() -> String {
        switch self {
        case .politics: return "정치"
        case .economy: return "경제"
        case .society: return "사회"
        case .world: return "세계"
        case .lifestyleCulture: return "생활/문화"
        case .itScience: return "IT/과학"
        }
    }
    
}
