//
//  ThemeType.swift
//  NewsHabit
//
//  Created by jiyeon on 2/20/24.
//

import Foundation
import UIKit

enum ThemeType: String, Codable, CaseIterable {
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
    
    func toUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light: UIUserInterfaceStyle.light
        case .dark: UIUserInterfaceStyle.dark
        case .system: UIUserInterfaceStyle.unspecified
        }
    }
}
