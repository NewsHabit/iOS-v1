//
//  HotNewsCellViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import Foundation

class HotNewsCellViewModel {
    
    let newsItem: HotNewsItem
    
    init(newsItem: HotNewsItem) {
        self.newsItem = newsItem
    }
    
    var title: String? {
        newsItem.title
    }
    
    var description: String? {
        newsItem.description
    }
    
    var imageLink: String? {
        newsItem.imgLink
    }
    
    var newsLink: String? {
        newsItem.naverUrl
    }
    
}
