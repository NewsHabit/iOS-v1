//
//  NicknameViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import UIKit

protocol NicknameViewDelegate {
    func getTabBarHeight() -> CGFloat
    func popViewController()
}

class NicknameViewController: BaseNavigationBarController<NicknameView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? NicknameView
        else { fatalError("error: NicknameViewController viewDidLoad")}
        contentView.delegate = self
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.button)
        setNavigationBarRightItemButtonHidden(true)
    }
        
}

extension NicknameViewController: NicknameViewDelegate {
    
    func getTabBarHeight() -> CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
}
