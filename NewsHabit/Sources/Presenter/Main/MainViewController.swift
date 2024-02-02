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
        
    }
    
}
