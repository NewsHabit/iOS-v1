//
//  HotNewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

final class HotNewsViewController: BaseViewController<HotNewsView>, BaseViewControllerProtocol {
    
    private let viewModel = HotNewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        contentView.delegate = self
        contentView.bind(with: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.send(.getHotNews)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarBackButtonHidden(true)
        setNavigationBarShareButtonHidden(true)
        setNavigationBarLargeTitle("🔥 지금 뜨는 뉴스")
        setNavigationBarSubTitleTextColor(.newsHabitGray)
    }
    
}

extension HotNewsViewController: HotNewsViewDelegate {
    
    func updateDate() {
        setNavigationBarSubTitle("\(Date().toFullDateTimeString()) 기준")
    }
    
    func openNewsLink(with url: String?) {
        let newsViewController = WebViewController()
        newsViewController.urlString = url
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
}

extension HotNewsViewController: Scrollable {
    
    func activateScroll() {
        contentView.scrollToTop()
    }
    
}
