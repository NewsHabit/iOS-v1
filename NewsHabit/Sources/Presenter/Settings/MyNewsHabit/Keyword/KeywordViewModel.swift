//
//  KeywordViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import Foundation

class KeywordViewModel {
    
    @Published var selectedKeywordIndex = Set(UserDefaultsManager.keywordList)
    
    // MARK: - Functions
    
    func selectKeyword(at indexPath: IndexPath) {
        if selectedKeywordIndex.count > 1 && selectedKeywordIndex.contains(indexPath.row) {
            selectedKeywordIndex.remove(indexPath.row)
        } else {
            selectedKeywordIndex.insert(indexPath.row)
        }
    }
    
}
