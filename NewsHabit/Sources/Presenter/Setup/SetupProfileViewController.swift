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
    
    private let label = UILabel().then {
        $0.text = "👋🏻 환영합니다!\n뉴빗과 함께 습관을 만들어보아요"
        $0.font = .title
        $0.numberOfLines = 0
    }
    
    private let profileView = ProfileView()
    
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
        guard let username = profileView.textField.text, !username.isEmpty, username.count <= profileView.maxNameLength else { return }
        UserDefaultsManager.username = username
        profileView.endEditing(true)
        navigationController?.pushViewController(SetupCategoryViewController(), animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .background
        
        view.addSubview(label)
        view.addSubview(profileView)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(20)
        }
        profileView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        profileView.setSaveButtonHidden()
        profileView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            let isValid = !text.isEmpty && text.count <= profileView.maxNameLength
            self.navigationItem.rightBarButtonItem?.isEnabled = isValid
            self.navigationItem.rightBarButtonItem?.tintColor = isValid ? .label : .newsHabitGray
        }
    }
    
}
