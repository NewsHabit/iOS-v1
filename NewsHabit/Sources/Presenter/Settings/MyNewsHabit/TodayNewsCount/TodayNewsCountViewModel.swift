//
//  TodayNewsCountViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import Foundation

class TodayNewsCountViewModel {
    
    @Published var selectedIndex: Int
    
    init() {
        switch UserDefaultsManager.todayNewsCount {
        case 3: selectedIndex = 0
        case 4: selectedIndex = 1
        case 5: selectedIndex = 2
        default: fatalError()
        }
    }

}
