//
//  ProfileView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

class ProfileView: UIView {
    
    // MARK: - Properties
    
    var delegate: ProfileViewDelegate?
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.text = "이름을 입력하세요"
        $0.textColor = .label
        $0.font = .titleFont
    }
    
    let subTitleLabel = UILabel().then {
        $0.text = "언제든지 변경할 수 있어요"
        $0.textColor = .newsHabitGray
        $0.font = .subTitleFont
    }
    
    let textField = UITextField().then {
        $0.text = UserDefaultsManager.username
        $0.font = .labelFont
        $0.borderStyle = .roundedRect
    }
    
    let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.labelFont]))
        $0.tintColor = .white
        $0.backgroundColor = .newsHabitGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(textField)
        addSubview(saveButton)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
    }
    
    // MARK: - Functions
    
    @objc private func handleSaveButtonTap() {
        guard let username = textField.text else { return }
        UserDefaultsManager.username = username
        endEditing(true)
        delegate?.popViewController()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let delegate = delegate,
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        UIView.animate(withDuration: 0.3) {
            self.saveButton.transform = CGAffineTransform(
                translationX: 0,
                y: delegate.getTabBarHeight() - keyboardSize.height // 탭바 크기
            )
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.saveButton.transform = .identity
        }
    }
    
}
