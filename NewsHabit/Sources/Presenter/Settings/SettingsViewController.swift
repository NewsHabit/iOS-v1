//
//  SettingsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

protocol SettingsViewDelegate {
    func pushViewController(settingsType: SettingsType)
}

class SettingsViewController: BaseViewController<SettingsView>, BaseViewControllerProtocol {
    
    private let viewModel = SettingsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? SettingsView else { return }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
        viewModel.input.send(.viewDidLoad)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarBackButtonHidden(true)
        setNavigationBarShareButtonHidden(true)
        setNavigationBarLargeTitle("설정")
    }
    
}

extension SettingsViewController: SettingsViewDelegate {
    
    func pushViewController(settingsType: SettingsType) {
        switch settingsType {
        case .profile:
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        case .myNewsHabit: 
            navigationController?.pushViewController(MyNewsHabitViewController(), animated: true)
        case .notification:
            navigationController?.pushViewController(NotificationViewController(), animated: true)
        case .theme:
            navigationController?.pushViewController(ThemeViewController(), animated: true)
        case .developer:
            let developerInfoViewcontroller = WebViewController()
            developerInfoViewcontroller.setShareButtonEnabled(false)
            navigationController?.pushViewController(developerInfoViewcontroller, animated: true)
        }
    }
    
}
