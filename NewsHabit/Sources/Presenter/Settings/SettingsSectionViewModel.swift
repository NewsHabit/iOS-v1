//
//  SettingsSectionViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import Foundation

class SettingsSectionViewModel: Identifiable {
    
    var cellViewModels: [SettingsCellViewModel]?
    
    let id = UUID()
    var title: String
    
    init(title: String, cellViewModels: [SettingsCellViewModel]? = nil) {
        self.title = title
        self.cellViewModels = cellViewModels
    }
    
}

