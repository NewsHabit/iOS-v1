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

final class MainViewController: BaseViewController<MainView>, BaseViewControllerProtocol {
    
    private let mainViewModel = MainViewModel()
    private let todayNewsViewModel = TodayNewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        // 알림 권한 설정
        NotificationCenterManager.shared.requestAuthorization { isAuthorized, error in
            UserDefaultsManager.isNotificationOn = isAuthorized
            if isAuthorized {
                if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                    NotificationCenterManager.shared.addNotification(for: notificationTime)
                }
            }
        }
        
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
    
}

extension MainViewController: Scrollable {
    
    func activateScroll() {
        guard let contentView = contentView as? MainView else { return }
        let indexPath = IndexPath(row: 0, section: 0)
        // 테이블 뷰의 섹션 0에 적어도 하나 이상의 행이 있는지 확인
        if contentView.todayNewsView.tableView.numberOfRows(inSection: indexPath.section) > 0 {
            contentView.todayNewsView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}
