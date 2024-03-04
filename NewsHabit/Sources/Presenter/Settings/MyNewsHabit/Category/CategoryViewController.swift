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
    
    var delegate: MyNewsHabitViewDelegate?
    private let viewModel = KeywordViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
<<<<<<< HEAD:NewsHabit/Sources/Presenter/Settings/MyNewsHabit/Category/CategoryViewController.swift
        sheetView.bindViewModel(CategoryViewModel())
=======
        sheetView.bindViewModel(viewModel)
>>>>>>> 94cc61ccd02e21ab174bd548d59972abc9802ace:NewsHabit/Sources/Presenter/Settings/MyNewsHabit/Keyword/KeywordViewController.swift
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
