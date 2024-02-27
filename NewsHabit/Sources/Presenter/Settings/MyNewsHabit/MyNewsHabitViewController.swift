//
//  MyNewsHabitViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

protocol MyNewsHabitViewDelegate {
    func present(_ indexPath: IndexPath)
    func updateMyNewsHabitSettings()
}

class MyNewsHabitViewController: BaseViewController<MyNewsHabitView>, BaseViewControllerProtocol {
    
    // MARK: - Properties
    
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
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("나의 뉴빗")
    }
    
}

extension MyNewsHabitViewController: MyNewsHabitViewDelegate {
    
    func present(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: 
            let categoryViewController = CategoryViewController(bottomSheetHeight: 400.0)
            categoryViewController.delegate = self
            present(categoryViewController, animated: false)
        case 1:
            let todayNewsCountViewController = TodayNewsCountViewController(bottomSheetHeight: 400.0)
            todayNewsCountViewController.delegate = self
            present(todayNewsCountViewController, animated: false)
        default: break
        }
    }
    
    func updateMyNewsHabitSettings() {
        viewModel.input.send(.updateMyNewsHabitSettings)
    }
    
}
