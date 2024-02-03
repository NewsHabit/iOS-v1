//
//  SettingsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

class SettingsViewController: BaseNavigationBarController<SettingsView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.title)
        setNavigationBarLargeTitleText("설정")
        setNavigationBarSubTitleHidden(true)
    }
    
}
