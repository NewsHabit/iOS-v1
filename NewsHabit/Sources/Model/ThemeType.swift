//
//  ThemeType.swift
//  NewsHabit
//
//  Created by jiyeon on 2/20/24.
//

import Foundation

enum ThemeType: String, CaseIterable {
    case light = "라이트"
    case dark = "다크"
    case system = "시스템 설정"
    
    func toImageString() -> String {
        switch self {
        case .light: "circle"
        case .dark: "circle.fill"
        case .system: "circle.righthalf.filled"
        }
    }

    static func indexOf(rawValue: String) -> Int? {
        return allCases.firstIndex { $0.rawValue == rawValue }
    }
}
