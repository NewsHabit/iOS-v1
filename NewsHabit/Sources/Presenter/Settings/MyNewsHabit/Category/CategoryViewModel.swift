//
//  CategoryViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import Foundation

final class CategoryViewModel {

    // MARK: - Properties
    
    @Published var selectedCategoryIndex:Set<Int>

    
    // MARK: - Initializer
    
    init() {
        selectedCategoryIndex = Set(UserDefaultsManager.categoryList)
    }
    
    // MARK: - Functions
    
    func selectCategory(at indexPath: IndexPath) {
        if selectedCategoryIndex.count > 1 && selectedCategoryIndex.contains(indexPath.row) {
            selectedCategoryIndex.remove(indexPath.row)
        } else {
            selectedCategoryIndex.insert(indexPath.row)
        }
    }
    
}
