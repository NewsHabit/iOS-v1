//
//  HotNewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

protocol HotNewsViewDelegate {
    func pushViewController(_ newsLink: String?)
}

class HotNewsViewController: BaseViewController<HotNewsView> {
    
    // MARK: - Properties
    
    private let viewModel = HotNewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? HotNewsView else { return }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarSubTitle("\(Date().toFullString()) 기준")
        viewModel.input.send(.viewWillAppear)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitle("🔥 지금 뜨는 뉴스")
        setNavigationBarSubTitleTextColor(.newsHabitGray)
    }
    
}

extension HotNewsViewController: HotNewsViewDelegate {
    
    func pushViewController(_ newsLink: String?) {
        guard let newsLink = newsLink else { return }
        let newsViewController = NewsViewController()
        newsViewController.newLink = newsLink
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
}
