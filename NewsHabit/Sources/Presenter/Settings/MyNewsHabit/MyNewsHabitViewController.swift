//
//  MyNewsHabitViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

protocol MyNewsHabitViewDelegate: AnyObject {
    func navigateTo(myNewsHabitType: MyNewsHabitType)
    func updateMyNewsHabitSettings()
}

final class MyNewsHabitViewController: BaseViewController<MyNewsHabitView>, BaseViewControllerProtocol {
    
    private let viewModel = MyNewsHabitViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        contentView.delegate = self
        contentView.bind(with: viewModel)
        viewModel.input.send(.updateMyNewsHabitSettings)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonHidden(true)
        setNavigationBarTitle("나의 뉴빗")
    }
    
}

extension MyNewsHabitViewController: MyNewsHabitViewDelegate {
    
    func navigateTo(myNewsHabitType: MyNewsHabitType) {
        switch myNewsHabitType {
        case .category:
            let keywordViewController = CategoryViewController()
            keywordViewController.delegate = self
            present(keywordViewController, animated: false)
        case .todayNewsCount:
            let todayNewsCountViewController = TodayNewsCountViewController()
            todayNewsCountViewController.delegate = self
            present(todayNewsCountViewController, animated: false)
        }
    }
    
    func updateMyNewsHabitSettings() {
        viewModel.input.send(.updateMyNewsHabitSettings)
    }
    
}
