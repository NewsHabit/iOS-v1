//
//  NewsItem.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

struct NewsItem: Codable {
    let title: String
    let category: String
    let naverUrl: String
    let imgLink: String
    let description: String
}

struct NewsResponse: Codable {
    let newsResponseDtoList: [NewsItem]
}
