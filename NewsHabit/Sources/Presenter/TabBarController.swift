//
//  TabBarController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        delegate = self
    }
    
    // MARK: - Setup TabBar
    
    private func setupTabBar() {
        tabBar.tintColor = .label
        tabBar.backgroundColor = .background
        
        viewControllers = [
            setupNavigationController(
                viewController: MainViewController(),
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house.fill")
            ),
            setupNavigationController(
                viewController: HotNewsViewController(),
                image: UIImage(systemName: "flame"),
                selectedImage: UIImage(systemName: "flame.fill")
            ),
            setupNavigationController(
                viewController: SettingsViewController(),
                image: UIImage(systemName: "gearshape"),
                selectedImage: UIImage(systemName: "gearshape.fill")
            )
        ]
    }
    
    private func setupNavigationController(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(
            title: "",
            image: image?.withRenderingMode(.alwaysOriginal).resized(toHeight: 19),
            selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal).resized(toHeight: 19)
        )
        return UINavigationController(rootViewController: viewController)
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let currentVC = selectedViewController, currentVC == viewController {
            if let navVC = viewController as? UINavigationController, let topVC = navVC.viewControllers.first {
                scrollToTop(viewController: topVC)
            }
            return false // 같은 탭을 다시 선택했을 때의 기본 동작을 방지
        }
        return true
    }
    
    private func scrollToTop(viewController: UIViewController) {
        if let mainViewController = viewController as? MainViewController {
            mainViewController.scrollToTop()
        } else if let hotViewController = viewController as? HotNewsViewController {
            hotViewController.scrollToTop()
        }
    }
}
