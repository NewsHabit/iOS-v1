//
//  KeywordViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import UIKit

class KeywordViewController: BaseNavigationBarController<KeywordView> {
    
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
