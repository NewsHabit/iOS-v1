//
//  MainViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class MainViewController: BaseViewController<MainView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
    }
    
    // MARK: - BaseViewControllerProtocol
    
    override func setupNavigationBar() {
        setBackgroundColor(.newsHabitDarkGray)
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitleTextColor(.white)
        setNavigationBarSubTitle("👀 42일 째 모두 읽으셨어요!")
        setNavigationBarSubTitleTextColor(.white)
    }
    
}
