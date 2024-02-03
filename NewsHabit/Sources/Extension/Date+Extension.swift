//
//  Date+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import Foundation

class NewsHabitDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyyy년 M월 d일 HH:00"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension Date {
    
    func toString() -> String {
        return NewsHabitDateFormatter().string(from: self)
    }
    
}
