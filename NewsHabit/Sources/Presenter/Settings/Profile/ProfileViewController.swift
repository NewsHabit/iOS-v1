//
//  ProfileViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

protocol ProfileViewDelegate {
    func getTabBarHeight() -> CGFloat
    func popViewController()
}

class ProfileViewController: BaseViewController<ProfileView>, BaseViewControllerProtocol {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? ProfileView else { return }
        contentView.delegate = self
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("프로필")
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    
    func getTabBarHeight() -> CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
}
