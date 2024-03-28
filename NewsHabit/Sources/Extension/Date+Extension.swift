//
//  Date+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

/// 전체 날짜 및 시간 형식을 제공하는 DateFormatter
/// 사용처: `HotNewsViewController`의 서브 타이틀에 날짜와 시간 표시
final class FullDateTimeFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyyy년 M월 d일 HH:00"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 간략화된 날짜 형식을 제공하는 DateFormatter
/// 사용처: 오늘의 뉴스 데이터를 요청할지 결정하기 위해 사용
final class CompactDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyMMdd"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 시간 형식을 제공하는 DateFormatter
/// 사용처: `NotificationViewController`에서 알림 시간 표시
final class SimpleTimeFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "hh:mm a"
        locale = Locale(identifier: "en_US_POSIX") // 12시간제 AM/PM 표기 로케일
        timeZone = TimeZone(identifier: "Asia/Seoul")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class MonthFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyMM"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class DayFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "dd"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class YearMonthFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "yyyy년 MM월"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Date {
    
    /// 전체 날짜와 시간을 문자열로 변환
    func toFullDateTimeString() -> String {
        return FullDateTimeFormatter().string(from: self)
    }
    
    /// 날짜를 간략화된 형태의 문자열로 변환
    func toCompactDateString() -> String {
        return CompactDateFormatter().string(from: self)
    }
    
    /// 시간을 간단한 형태의 문자열로 변환
    func toSimpleTimeString() -> String {
        return SimpleTimeFormatter().string(from: self)
    }
    
    func toMonthString() -> String {
        return MonthFormatter().string(from: self)
    }
    
    func toDayString() -> String {
        return DayFormatter().string(from: self)
    }
    
    func toYearMonthString() -> String {
        return YearMonthFormatter().string(from: self)
    }
    
}

extension String {
    
    /// 문자열을 Date 객체로 변환
    func toTimeAsDate() -> Date? {
        return SimpleTimeFormatter().date(from: self)
    }
    
}
