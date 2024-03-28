//
//  UIColor+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

extension UIColor {
    
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    private static func color(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
    
    static let newsHabit = UIColor(hex: 0xA6CFB2)
    static let newsHabitAccent = UIColor(hex: 0xF15454)
    static let newsHabitLightGray = color(light: UIColor(hex: 0xD9D9D9), dark: UIColor(hex: 0x7C7C7C))
    static let newsHabitGray = color(light: UIColor(hex: 0x7C7C7C), dark: UIColor(hex: 0xB4B4B4))
    static let newsHabitDarkGray = color(light: UIColor(hex: 0x2D2D2D), dark: .black)
    static let background = color(light: .white, dark: UIColor(hex: 0x242424))
    
}
