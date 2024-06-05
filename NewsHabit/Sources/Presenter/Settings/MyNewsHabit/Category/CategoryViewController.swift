//
//  CategoryViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

final class CategoryViewController: BottomSheetController<CategoryView> {
    
    weak var delegate: MyNewsHabitViewDelegate?
    private let viewModel = CategoryViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        sheetView.bindViewModel(viewModel)
        sheetView.setSubTitle(with: "변경 시 내일부터 적용돼요")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateMyNewsHabitSettings()
    }
    
}

extension CategoryViewController: CategoryViewDelegate {
    
    func popViewController() {
        hideBottomSheets()
    }
    
}
