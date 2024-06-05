//
//  SetupCategoryViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 3/27/24.
//

import UIKit

class SetupCategoryViewController: UIViewController, BaseViewControllerProtocol {
    
    private let viewModel = CategoryViewModel()
    
    // MARK: - UI Components
    
    private let categoryView = CategoryView().then {
        $0.setSubTitle(with: "여러 개 선택할 수 있어요")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(handleNextButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func handleNextButton() {
        var categoryIndexArray = Array(viewModel.selectedCategoryIndex)
        categoryIndexArray.sort()
        UserDefaultsManager.categoryList = categoryIndexArray
        navigationController?.pushViewController(SetupTodayNewsCountViewController(), animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .background
        
        view.addSubview(categoryView)
        
        categoryView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        categoryView.setSaveButtonHidden()
        categoryView.bind(with: viewModel)
    }
    
}
