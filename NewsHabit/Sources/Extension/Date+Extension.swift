//
//  Date+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

/// DateFormatter를 생성하는 유틸리티 클래스
final class DateFormatterFactory {
    
    static func create(withFormat format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }
    
}

extension Date {
    
    /// 전체 날짜와 시간을 문자열로 변환
    func toFullDateTimeString() -> String {
        let formatter = DateFormatterFactory.create(withFormat: "yyyy년 M월 d일 HH:00")
        return formatter.string(from: self)
    }
    
    /// 날짜를 간략화된 형태의 문자열로 변환
    func toCompactDateString() -> String {
        let formatter = DateFormatterFactory.create(withFormat: "yyMMdd")
        return formatter.string(from: self)
    }
    
    /// 시간을 간단한 형태의 문자열로 변환
    func toSimpleTimeString() -> String {
        let formatter = DateFormatterFactory.create(withFormat: "hh:mm a")
        return formatter.string(from: self)
    }
    
    /// 월을 간략화된 형태의 문자열로 변환
    func toMonthString() -> String {
        let formatter = DateFormatterFactory.create(withFormat: "yyMM")
        return formatter.string(from: self)
    }
    
    /// 일을 간략화된 형태의 문자열로 변환
    func toDayString() -> String {
        let formatter = DateFormatterFactory.create(withFormat: "dd")
        return formatter.string(from: self)
    }
    
    /// 년도와 월을 간략화된 형태의 문자열로 변환
    func toYearMonthString() -> String {
        let formatter = DateFormatterFactory.create(withFormat: "yyyy년 MM월")
        return formatter.string(from: self)
    }
    
}

extension String {
    
    /// 문자열을 Date 객체로 변환
    func toTimeAsDate() -> Date? {
        let formatter = DateFormatterFactory.create(withFormat: "hh:mm a")
        return formatter.date(from: self)
    }
    
}
