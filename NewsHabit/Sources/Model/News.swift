//
//  News.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

struct TodayNewsItem: Codable {
    let title: String
    let category: String
    let naverUrl: String
    let imgLink: String
    let description: String
}

struct TodayNewsItemState: Codable {
    let newsItem: TodayNewsItem
    var isRead: Bool = false
}

struct TodayNewsResponse: Codable {
    let todayNewsResponseDtoList: [TodayNewsItem]
}

struct HotNewsItem: Codable {
    let title: String
    let naverUrl: String
    let imgLink: String
    let description: String
}

struct HotNewsResponse: Codable {
    let hotNewsResponseDtoList: [HotNewsItem]
}
