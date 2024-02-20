//
//  ThemeViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/20/24.
//

import Combine
import Foundation

class ThemeViewModel {
    
    @Published var selectedIndex: Int = (ThemeType.indexOf(rawValue: UserDefaultsManager.theme) ?? 0)
    
}
