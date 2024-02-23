//
//  NewsCellViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import Foundation

class NewsCellViewModel {
    
    let newsItem: NewsItem
    
    let isDetailCell: Bool
    
    init(newsItem: NewsItem, isDetailCell: Bool) {
        self.newsItem = newsItem
        self.isDetailCell = isDetailCell
    }
    
    var title: String? {
        newsItem.title
    }
    
    var description: String? {
        newsItem.description
    }
    
    var category: String? {
        newsItem.category
    }
    
    var imageLink: String? {
        newsItem.imgLink
    }
    
    @Published var isRead: Bool = false
    
}
