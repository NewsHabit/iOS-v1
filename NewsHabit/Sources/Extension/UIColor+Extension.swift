//
//  UIColor+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

extension UIColor {
    
    convenience init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
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
