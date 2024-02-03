//
//  MainViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/2/24.
//

import Combine
import Foundation

class MainViewModel {
    
    enum MenuOption {
        case todayNews
        case monthlyRecord
    }
    
    @Published var selectedMenu: MenuOption = .todayNews
    
}
