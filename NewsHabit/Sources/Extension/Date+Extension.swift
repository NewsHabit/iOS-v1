//
//  Date+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

class NewsHabitFullDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyyy년 M월 d일 HH:00"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class NewsHabitSimpleDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyMMddHH"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension Date {
    
    func toFullString() -> String {
        return NewsHabitFullDateFormatter().string(from: self)
    }
    
    func toSimpleString() -> String {
        return NewsHabitSimpleDateFormatter().string(from: self)
    }
    
}
