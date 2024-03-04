//
//  SettingsItem.swift
//  NewsHabit
//
//  Created by jiyeon on 3/2/24.
//

import Foundation

enum SettingsType: String {
    case profile = "프로필"
    case myNewsHabit = "나의 뉴빗"
    case notification = "알림"
    case theme = "테마"
    case developer = "개발자 정보"
}

struct SettingsItem {
    let type: SettingsType
    let imageString: String
}
