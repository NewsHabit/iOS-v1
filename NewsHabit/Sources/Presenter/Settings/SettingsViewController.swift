//
//  SettingsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

protocol SettingsViewDelegate {
    func pushViewController(_ indexPath: IndexPath)
}

class SettingsViewController: BaseViewController<SettingsView>, BaseViewControllerProtocol {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? SettingsView else { return }
        contentView.delegate = self
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitle("설정")
    }
    
}

extension SettingsViewController: SettingsViewDelegate {
    
    func pushViewController(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: navigationController?.pushViewController(ProfileViewController(), animated: true)
        case 1: navigationController?.pushViewController(MyNewsHabitViewController(), animated: true)
        case 2: navigationController?.pushViewController(NotificationViewController(), animated: true)
        case 3: navigationController?.pushViewController(ThemeViewController(), animated: true)
        case 4: navigationController?.pushViewController(DeveloperInfoViewController(), animated: true)
        default: break
        }
    }
    
}
