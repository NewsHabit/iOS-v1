//
//  TabBarController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = UIColor(red: 166/255, green: 207/255, blue: 178/255, alpha: 1) // 📌
        viewControllers = [
            setupViewController(
                viewController: TrendingNewsViewController(),
                image: UIImage(systemName: "flame.fill")
            ),
            setupViewController(
                viewController: MainViewController(),
                image: UIImage(systemName: "house.fill")
            ),
            setupViewController(
                viewController: SettingsViewController(),
                image: UIImage(systemName: "gearshape.fill")
            )
        ]
        selectedIndex = 1
    }
    
    private func setupViewController(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = ""
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }
    
}
