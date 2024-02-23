//
//  HotNewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class HotNewsViewController: BaseViewController<HotNewsView> {
    
    // MARK: - Properties
    
    private let viewModel = HotNewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? HotNewsView else { return }
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
