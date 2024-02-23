//
//  TabBarController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
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
        tabBar.tintColor = .label
        tabBar.backgroundColor = .background
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
