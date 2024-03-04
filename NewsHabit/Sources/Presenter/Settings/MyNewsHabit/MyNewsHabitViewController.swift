//
//  MyNewsHabitViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

protocol MyNewsHabitViewDelegate {
    func pushViewController(myNewsHabitType: MyNewsHabitType)
    func updateMyNewsHabitSettings()
}

class MyNewsHabitViewController: BaseViewController<MyNewsHabitView>, BaseViewControllerProtocol {
    
    private let viewModel = MyNewsHabitViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? MyNewsHabitView else { return }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
        viewModel.input.send(.updateMyNewsHabitSettings)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonHidden(true)
        setNavigationBarTitle("나의 뉴빗")
    }
    
}

extension MyNewsHabitViewController: MyNewsHabitViewDelegate {
    
<<<<<<< HEAD
    func present(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: 
            let categoryViewController = CategoryViewController(bottomSheetHeight: 400.0)
            categoryViewController.delegate = self
            present(categoryViewController, animated: false)
        case 1:
=======
    func pushViewController(myNewsHabitType: MyNewsHabitType) {
        switch myNewsHabitType {
        case .keyword:
            let keywordViewController = KeywordViewController(bottomSheetHeight: 400.0)
            keywordViewController.delegate = self
            present(keywordViewController, animated: false)
        case .todayNewsCount:
>>>>>>> 94cc61ccd02e21ab174bd548d59972abc9802ace
            let todayNewsCountViewController = TodayNewsCountViewController(bottomSheetHeight: 400.0)
            todayNewsCountViewController.delegate = self
            present(todayNewsCountViewController, animated: false)
        }
    }
    
    func updateMyNewsHabitSettings() {
        viewModel.input.send(.updateMyNewsHabitSettings)
    }
    
}
