//
//  SettingsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

protocol SettingsDelegate {
    func pushViewController(_ settingsType: SettingsType)
}

class SettingsViewController: BaseNavigationBarController<SettingsView> {
    
    // MARK: - Properties
    
    private let viewModel = SettingsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? SettingsView 
        else { fatalError("error: SettingsViewController viewDidLoad") }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
//        viewModel.input.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.send(.viewWillAppear)
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.title)
        setNavigationBarLargeTitleText("설정")
        setNavigationBarSubTitleHidden(true)
    }
    
}

extension SettingsViewController: SettingsDelegate {
    
    func pushViewController(_ settingsType: SettingsType) {
        switch settingsType {
        case .nickname:
            navigationController?.pushViewController(NicknameViewController(), animated: true)
        case .keyword:
            navigationController?.pushViewController(KeywordViewController(), animated: true)
        case .todayNewsCount:
            navigationController?.pushViewController(TodayNewsCountViewController(), animated: true)
        case .notification:
            navigationController?.pushViewController(NotificationViewController(), animated: true)
        case .theme:
            navigationController?.pushViewController(ThemeViewController(), animated: true)
        }
    }
    
}
