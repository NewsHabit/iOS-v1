//
//  MainViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

protocol TodayNewsViewDelegate {
    func pushViewController(_ newsLink: String?)
    func updateDaysAllReadCount()
}

class MainViewController: BaseViewController<MainView>, BaseViewControllerProtocol {
    
    // MARK: - Properties
    
    private let viewModel = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? MainView else { return }
        contentView.todayNewsView.delegate = self
        contentView.bindViewModel(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setBackgroundColor(.newsHabitDarkGray)
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitleTextColor(.white)
        setNavigationBarSubTitle("👀 \(UserDefaultsManager.daysAllRead)일 째 모두 읽으셨어요!")
        setNavigationBarSubTitleTextColor(.white)
    }
    
}

extension MainViewController: TodayNewsViewDelegate {
    
    func pushViewController(_ newsLink: String?) {
        guard let newsLink = newsLink else { return }
        let newsViewController = WebViewController()
        newsViewController.urlString = newsLink
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
    func updateDaysAllReadCount() {
        setNavigationBarSubTitle("👀 \(UserDefaultsManager.daysAllRead)일 째 모두 읽으셨어요!")
    }
    
}
