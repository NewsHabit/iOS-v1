//
//  SettingsType.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import Foundation

public enum SettingsType: String, CaseIterable {
    case name
    case category
    case newsCount
    case notification
    case developer
    case reset
    
    var title: String {
        switch self {
        case .name:         "이름"
        case .category:     "카테고리"
        case .newsCount:    "기사 개수"
        case .notification: "알림"
        case .developer:    "개발자 정보"
        case .reset:        "데이터 초기화"
        }
    }
    
    var section: Int {
        switch self {
        case .name, .category, .newsCount, .notification:   0
        case .developer, .reset:                            1
        }
    }
}

extension SettingsType {
    enum Mode {
        case none
        case chevron
        case description
    }
    
    var mode: Mode {
        switch self {
        case .developer:    .chevron
        case .reset:        .none
        default:            .description
        }
    }
}
