//
//  SetupProfileViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 3/27/24.
//

import UIKit

import SnapKit

class SetupProfileViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - UI Components
    
    let profileView = ProfileView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        profileView.saveButton.isHidden = true
        setupNavigationBar()
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(handleNextButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func handleNextButton() {
        guard let username = profileView.textField.text, !username.isEmpty, username.count <= 6 else { return }
        UserDefaultsManager.username = username
        profileView.endEditing(true)
        navigationController?.pushViewController(SetupCategoryViewController(), animated: true)
    }
    
}
