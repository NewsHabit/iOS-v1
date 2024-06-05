//
//  TabBarController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

protocol Scrollable {
    func activateScroll()
}

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
        guard let navVC = viewController as? UINavigationController, 
                let topVC = navVC.viewControllers.first as? Scrollable else {
            return true
        }
        
        if navVC.viewControllers.count == 1 {
            topVC.activateScroll()
        }
        
        return true
    }
    
}
