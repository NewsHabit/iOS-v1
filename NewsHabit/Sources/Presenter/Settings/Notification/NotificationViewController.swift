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
            title: "알림 권한 필요",
            message: "알림을 통해 키워드 뉴스를 바로 받아보세요. 설정에서 언제든지 이를 변경할 수 있습니다.",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "설정으로 이동",
            style: .default,
            handler: openAppSettings
        )
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    private func openAppSettings(_ sender: UIAlertAction) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        navigationController?.popViewController(animated: false)
    }
}
