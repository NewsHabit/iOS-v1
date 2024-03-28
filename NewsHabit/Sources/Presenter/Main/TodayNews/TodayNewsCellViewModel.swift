//
//  TodayNewsCellViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/27/24.
//

import Foundation

final class TodayNewsCellViewModel {
    
    var newsItemState: TodayNewsItemState
    
    @Published var isRead: Bool {
        didSet {
            newsItemState.isRead = isRead
        }
    }
    
    init(_ newsItemState: TodayNewsItemState) {
        self.newsItemState = newsItemState
        isRead = newsItemState.isRead
    }
    
    var title: String {
        newsItemState.newsItem.title
    }
    
    var category: String {
        newsItemState.newsItem.category
    }
    
    var description: String {
        newsItemState.newsItem.description
    }
    
    var imageLink: String {
        newsItemState.newsItem.imgLink
    }
    
    var newsLink: String {
        newsItemState.newsItem.naverUrl
    }
    
}
