//
//  ThemeViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

class ThemeViewController: BaseViewController<ThemeView> {
    
    // MARK: - Properties
    
    private let viewModel = ThemeViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? ThemeView else { return }
        contentView.bindViewModel(viewModel)
    }
    
    override func setupNavigationBar() {
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("테마")
    }
    
}
