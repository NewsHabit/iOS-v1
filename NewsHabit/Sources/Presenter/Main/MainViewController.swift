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
    
    // MARK: - BaseViewControllerProtocol
    
    override func setupNavigationBar() {
        setBackgroundColor(.newsHabitDarkGray)
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
        setNavigationBarLargeTitleTextColor(.white)
        setNavigationBarSubTitle("👀 42일 째 모두 읽으셨어요!")
        setNavigationBarSubTitleTextColor(.white)
    }
    
}
