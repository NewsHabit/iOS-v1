//
//  Date+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

class FullDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyyy년 M월 d일 HH:00"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class SimpleDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyMMddHH"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TimeFormantter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "hh:mm a"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Date {
    
    func toFullString() -> String {
        return FullDateFormatter().string(from: self)
    }
    
    func toSimpleString() -> String {
        return SimpleDateFormatter().string(from: self)
    }
    
    func toTimeString() -> String {
        return TimeFormantter().string(from: self)
    }
    
}

extension String {
    
    func toDate() -> Date? {
        return TimeFormantter().date(from: self)
    }
    
}
