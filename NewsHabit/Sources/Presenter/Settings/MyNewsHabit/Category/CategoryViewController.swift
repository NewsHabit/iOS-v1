//
//  CategoryViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

protocol CategoryViewDelegate {
    func popViewController()
}

class CategoryViewController: BottomSheetController<CategoryView> {
    
    // MARK: - Properties
    
    var delegate: MyNewsHabitViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        sheetView.bindViewModel(CategoryViewModel())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateMyNewsHabitSettings()
    }
    
}

extension CategoryViewController: CategoryViewDelegate {
    
    func popViewController() {
        super.hideBottomSheets()
    }
    
}
