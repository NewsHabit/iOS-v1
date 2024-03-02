//
//  NotificationViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

class NotificationViewController: BaseViewController<NotificationView>, BaseViewControllerProtocol {
    
    private let viewModel = NotificationViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? NotificationView else { return }
        contentView.bindViewModel(viewModel)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("알림")
    }
    
}
