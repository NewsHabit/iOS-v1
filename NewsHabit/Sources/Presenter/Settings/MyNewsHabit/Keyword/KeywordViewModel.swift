//
//  KeywordViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import Foundation

class KeywordViewModel {

    // MARK: - Properties
    
    @Published var selectedKeywordIndex:Set<Int>

    
    // MARK: - Initializer
    
    init() {
        selectedKeywordIndex = Set(UserDefaultsManager.keyword)
    }
    
    // MARK: - Functions
    
    func selectKeyword(at indexPath: IndexPath) {
        if selectedKeywordIndex.count > 1 && selectedKeywordIndex.contains(indexPath.row) {
            selectedKeywordIndex.remove(indexPath.row)
        } else {
            selectedKeywordIndex.insert(indexPath.row)
        }
    }
    
}
