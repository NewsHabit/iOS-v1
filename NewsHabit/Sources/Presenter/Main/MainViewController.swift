//
//  MainViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

class MainViewController: BaseNavigationBarController<MainView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.button)
//        setBackgroundColor(UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)) // 📌
//        setNavigationBarLargeTitleText("홍길동님의 뉴빗")
//        setNavigationBarLargeTitleTextColor(.white)
//        setNavigationBarSubTitleText("👀 42일 째 모두 읽으셨어요!")
//        setNavigationBarSubTitleTextColor(.white)
    }
    
}
