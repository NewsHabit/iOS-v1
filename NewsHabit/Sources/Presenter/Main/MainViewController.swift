//
//  MainViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class MainViewController: BaseViewController<MainView>, BaseViewControllerProtocol {
    
    // MARK: - Properties
    
    private let viewModel = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? MainView else { return }
        contentView.bindViewModel(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarLargeTitle("\(UserDefaultsManager.username)님의 뉴빗")
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setBackgroundColor(.newsHabitDarkGray)
        setNavigationBarBackButtonHidden(true)
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarLargeTitleTextColor(.white)
        setNavigationBarSubTitle("👀 42일 째 모두 읽으셨어요!")
        setNavigationBarSubTitleTextColor(.white)
    }
    
}
