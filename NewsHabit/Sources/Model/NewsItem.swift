//
//  NewsItem.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Foundation

struct NewsItem {
    let title: String
    let description: String
    let category: String
//    let imageLink: String
//    let naverUrl: String
}

extension NewsItem {
    static let dummy = NewsItem(
        title: "제목이 들어올 자리입니다",
        description: "요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 ",
        category: "사회"
    )
}
