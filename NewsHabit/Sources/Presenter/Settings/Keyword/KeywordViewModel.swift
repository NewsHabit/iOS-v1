//
//  KeywordViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import Combine
import Foundation

class KeywordViewModel {

    // MARK: - Properties
    
    @Published var selectedKeywordIndex:Set<Int>

    
    // MARK: - Initializer
    
    init() {
        selectedKeywordIndex = Set(Settings.keyword)
    }
    
    // MARK: - Functions
    
    func selectKeyword(at indexPath: IndexPath) {
        if selectedKeywordIndex.contains(indexPath.row) {
            selectedKeywordIndex.remove(indexPath.row)
        } else if (selectedKeywordIndex.count < 3) {
            selectedKeywordIndex.insert(indexPath.row)
        }
    }
    
}
