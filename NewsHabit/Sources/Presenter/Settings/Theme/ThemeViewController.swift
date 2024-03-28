//
//  ThemeViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

final class ThemeViewController: BaseViewController<ThemeView>, BaseViewControllerProtocol {
    
    private let viewModel = ThemeViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? ThemeView else { return }
        contentView.bindViewModel(viewModel)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonHidden(true)
        setNavigationBarTitle("테마")
    }
    
}
