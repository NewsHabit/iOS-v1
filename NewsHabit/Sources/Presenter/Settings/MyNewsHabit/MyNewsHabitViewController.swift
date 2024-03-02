//
//  MyNewsHabitViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

protocol MyNewsHabitViewDelegate {
    func pushViewController(_ type: MyNewsHabitType)
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
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("나의 뉴빗")
    }
    
}

extension MyNewsHabitViewController: MyNewsHabitViewDelegate {
    
    func pushViewController(_ type: MyNewsHabitType) {
        switch type {
        case .keyword:
            let keywordViewController = KeywordViewController(bottomSheetHeight: 400.0)
            keywordViewController.delegate = self
            present(keywordViewController, animated: false)
        case .todayNewsCount:
            let todayNewsCountViewController = TodayNewsCountViewController(bottomSheetHeight: 400.0)
            todayNewsCountViewController.delegate = self
            present(todayNewsCountViewController, animated: false)
        }
    }
    
    func updateMyNewsHabitSettings() {
        viewModel.input.send(.updateMyNewsHabitSettings)
    }
    
}
