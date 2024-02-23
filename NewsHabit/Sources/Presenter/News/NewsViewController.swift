//
//  NewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit

class NewsViewController: BaseViewController<NewsView> {
    
    // MARK: - Properties
    
    var newLink: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let contentView = contentView as? NewsView else { return }
        contentView.loadLink(newLink)
    }
    
}
