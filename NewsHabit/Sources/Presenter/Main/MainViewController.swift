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
    func scrollToTop()
}

final class MainViewController: BaseViewController<MainView>, BaseViewControllerProtocol {
    
    private let mainViewModel = MainViewModel()
    private let todayNewsViewModel = TodayNewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? MainView else { return }
        contentView.todayNewsView.delegate = self
        contentView.bindViewModel(mainViewModel, todayNewsViewModel)
        mainViewModel.input.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todayNewsViewModel.input.send(.getTodayNews)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
        setNavigationBarSubTitle("👀 지금까지 \(UserDefaultsManager.numOfDaysAllRead)일 완독했어요!")
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setBackgroundColor(.newsHabitDarkGray)
        setNavigationBarBackButtonHidden(true)
        setNavigationBarShareButtonHidden(true)
        setNavigationBarLargeTitleTextColor(.white)
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
        setNavigationBarSubTitle("👀 지금까지 \(UserDefaultsManager.numOfDaysAllRead)일 완독했어요!")
        guard let contentView = contentView as? MainView else { return }
        contentView.monthlyRecordView.update()
    }
    
    func scrollToTop() {
        guard let contentView = contentView as? MainView else { return }
        contentView.todayNewsView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}
