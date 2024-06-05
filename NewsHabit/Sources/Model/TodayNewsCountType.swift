//
//  TodayNewsCountType.swift
//  NewsHabit
//
//  Created by jiyeon on 3/3/24.
//

import Foundation

enum TodayNewsCountType: Int, CaseIterable, Codable {
    
    case three = 3, four, five
    
    static func index(from count: Int) -> Int {
        guard let index = TodayNewsCountType.allCases.firstIndex(where: { $0.rawValue == count })
        else { fatalError("Unsupported news count") }
        return index
    }
    
    static func count(from index: Int) -> TodayNewsCountType {
        return TodayNewsCountType.allCases[index]
    }
}
