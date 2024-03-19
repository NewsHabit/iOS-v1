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

class MainViewController: BaseViewController<MainView>, BaseViewControllerProtocol {
    
    private let viewModel = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? MainView else { return }
        contentView.todayNewsView.delegate = self
        contentView.bindViewModel(viewModel)
        viewModel.input.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
        setNavigationBarSubTitle("👀 \(UserDefaultsManager.numOfDaysAllRead)일 째 모두 읽었어요!")
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
        setNavigationBarSubTitle("👀 \(UserDefaultsManager.numOfDaysAllRead)일 째 모두 읽으셨어요!")
        guard let contentView = contentView as? MainView else { return }
        contentView.monthlyRecordView.collectionView.reloadData()
    }
    
    func scrollToTop() {
        guard let contentView = contentView as? MainView else { return }
        contentView.todayNewsView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}
