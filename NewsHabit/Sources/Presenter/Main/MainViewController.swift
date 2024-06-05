//
//  MainViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

final class MainViewController: BaseViewController<MainView>, BaseViewControllerProtocol {
    
    private let mainViewModel = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        // 알림 권한 설정
        UserNotificationManager.shared.requestAuthorization { isAuthorized, error in
            UserDefaultsManager.isNotificationOn = isAuthorized
            if isAuthorized {
                if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                    UserNotificationManager.shared.addNotification(for: notificationTime)
                }
            }
        }
        
        contentView.todayNewsView.delegate = self
        contentView.bindViewModel(mainViewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainViewModel.input.send(.viewWillAppear)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
        updateSubTitle()
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setBackgroundColor(.newsHabitDarkGray)
        setNavigationBarBackButtonHidden(true)
        setNavigationBarShareButtonHidden(true)
        setNavigationBarLargeTitleTextColor(.white)
        setNavigationBarSubTitleTextColor(.white)
    }
    
    private func updateSubTitle() {
        setNavigationBarSubTitle("👀 지금까지 \(UserDefaultsManager.numOfDaysAllRead)일 완독했어요!")
    }
    
}

extension MainViewController: TodayNewsViewDelegate {
    
    func pushViewController(_ newsLink: String?) {
        guard let newsLink = newsLink else { return }
        let newsViewController = WebViewController()
        newsViewController.urlString = newsLink
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
    func updateNumOfDaysAllRead() {
        updateSubTitle()
        contentView.monthlyRecordView.update()
    }
    
}

extension MainViewController: Scrollable {
    
    func activateScroll() {
        contentView.todayNewsView.scrollToTop()
    }
    
}
