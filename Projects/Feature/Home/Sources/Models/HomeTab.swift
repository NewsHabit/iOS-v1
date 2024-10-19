//
//  HomeTab.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import Foundation

public enum HomeTab: CaseIterable {
    case daily
    case monthly
    case bookmark
    
    public var title: String {
        switch self {
        case .daily:    "오늘의 뉴스"
        case .monthly:  "이번 달 기록"
        case .bookmark: "북마크"
        }
    }
}
