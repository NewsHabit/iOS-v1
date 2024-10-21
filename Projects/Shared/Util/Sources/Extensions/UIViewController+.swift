//
//  UIViewController+.swift
//  SharedUtil
//
//  Created by 지연 on 10/21/24.
//

import UIKit

extension UIViewController {
    public func navigate(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func navigateWithTab(to viewController: UIViewController) {
        tabBarController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
