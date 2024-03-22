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

final class CategoryViewController: BottomSheetController<CategoryView> {
    
    var delegate: MyNewsHabitViewDelegate?
    private let viewModel = CategoryViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        sheetView.bindViewModel(viewModel)
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
