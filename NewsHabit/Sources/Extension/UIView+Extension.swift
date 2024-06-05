//
//  UIView+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/27/24.
//

import UIKit

extension UIView {
    
    func toUserInterfaceStyle(themeType: ThemeType) -> UIUserInterfaceStyle {
        switch themeType {
        case .light: UIUserInterfaceStyle.light
        case .dark: UIUserInterfaceStyle.dark
        case .system: UIUserInterfaceStyle.unspecified
        }
    }
    
}
