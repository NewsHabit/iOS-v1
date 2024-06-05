//
//  MyNewsHabitItem.swift
//  NewsHabit
//
//  Created by jiyeon on 3/3/24.
//

import Foundation

enum MyNewsHabitType: String {
    case category = "카테고리"
    case todayNewsCount = "오늘의 뉴스 개수"
}

struct MyNewsHabitItem {
    let type: MyNewsHabitType
    let description: String
}
