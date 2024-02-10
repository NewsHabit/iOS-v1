//
//  KeywordViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import UIKit

protocol KeywordViewDelegate {
    func popViewController()
}

class KeywordViewController: BaseNavigationBarController<KeywordView> {
    
    // MARK: - Properties
    
    private let viewModel = KeywordViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? KeywordView
        else { fatalError("error: KeywordViewController viewDidLoad") }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    override func setupNavigationBar() {
        setNavigationBarMode(.button)
        setNavigationBarRightItemButtonHidden(true)
    }
        
}

extension KeywordViewController: KeywordViewDelegate {
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
}
