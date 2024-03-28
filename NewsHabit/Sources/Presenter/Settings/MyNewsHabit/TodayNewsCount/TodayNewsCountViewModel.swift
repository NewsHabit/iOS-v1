//
//  TodayNewsCountViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import Foundation

final class TodayNewsCountViewModel {
    
    @Published var selectedIndex = TodayNewsCountType.index(from: UserDefaultsManager.todayNewsCount.rawValue)

}
