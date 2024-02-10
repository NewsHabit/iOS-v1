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
        setNavigationBarTitle("메인")
        setNavigationBarLargeTitle("사용자님의 뉴빗")
        setNavigationBarSubTitle("👀 42일 째 모두 읽으셨어요!")
    }
    
}
