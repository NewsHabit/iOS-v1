//
//  TrendingNewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

class TrendingNewsViewController: BaseNavigationBarController<TrendingNewsView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarSubTitleText("\(Date().toString()) 기준")
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.title)
        setNavigationBarLargeTitleText("🔥지금 뜨는 뉴스")
        setNavigationBarSubTitleTextColor(.gray)
        setNavigationBarSubTitleFont(.systemFont(ofSize: 14))
    }
    
}
