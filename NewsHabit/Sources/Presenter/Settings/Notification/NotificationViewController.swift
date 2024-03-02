//
//  NotificationViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

protocol NotificationViewDelegate {
    func showAlert()
}

class NotificationViewController: BaseViewController<NotificationView>, BaseViewControllerProtocol {
    
    private let viewModel = NotificationViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? NotificationView else { return }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("알림")
    }
    
}

extension NotificationViewController: NotificationViewDelegate {
    
    func showAlert() {
        let alertController = UIAlertController(
            title: "알림 허용 요청",
            message: "알림을 '허용'으로 변경해주세요.",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "설정창 이동",
            style: .default,
            handler: foo
        )
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
    }
    
    private func foo(_ sender: UIAlertAction) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
}
