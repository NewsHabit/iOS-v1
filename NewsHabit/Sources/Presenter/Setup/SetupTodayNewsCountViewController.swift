//
//  SetupTodayNewsCountViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 3/27/24.
//

import UIKit

class SetupTodayNewsCountViewController: UIViewController, BaseViewControllerProtocol {
    
    private let viewModel = TodayNewsCountViewModel()
    
    // MARK: - UI Components
    
    let todayNewsCountView = TodayNewsCountView().then {
        $0.subTitleLabel.text = ""
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubview(todayNewsCountView)
        todayNewsCountView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        todayNewsCountView.saveButton.isHidden = true
        todayNewsCountView.bindViewModel(viewModel)
        setupNavigationBar()
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(handleDoneButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func handleDoneButton() {
        UserDefaultsManager.todayNewsCount = TodayNewsCountType.count(from: viewModel.selectedIndex)
        UserDefaultsManager.isFirst = false
        guard let window = view.window else { return }
        window.rootViewController = TabBarController()
    }
    
}
