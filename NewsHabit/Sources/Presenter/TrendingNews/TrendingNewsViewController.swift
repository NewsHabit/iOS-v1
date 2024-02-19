//
//  TrendingNewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class TrendingNewsViewController: BaseViewController<TrendingNewsView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarSubTitle("\(Date().toString()) 기준")
    }
    
    // MARK: - BaseViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitle("🔥 지금 뜨는 뉴스")
        setNavigationBarSubTitleTextColor(.newsHabitGray)
    }
    
}
