//
//  ThemeViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import UIKit

class ThemeViewController: BaseNavigationBarController<ThemeView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.button)
        setNavigationBarRightItemButtonHidden(true)
    }
        
}
