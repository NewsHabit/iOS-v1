//
//  NewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit

class NewsViewController: BaseViewController<NewsView> {
    
    // MARK: - Properties
    
    var newsLink: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? NewsView else { return }
        contentView.loadLink(newsLink)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarLinkButtonAction(#selector(handleLinkButtonTap))
    }
    
    // MARK: - objc Function
    
    @objc private func handleLinkButtonTap() {
        guard let newsLink = newsLink else { return }
        let pasteboard = UIPasteboard.general
        pasteboard.string = newsLink
        Toast.shared.makeToast("원본 링크를 복사했습니다")
    }
    
}
