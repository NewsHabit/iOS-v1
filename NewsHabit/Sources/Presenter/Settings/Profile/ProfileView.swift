//
//  ProfileView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

protocol ProfileViewDelegate: AnyObject {
    func getTabBarHeight() -> CGFloat
    func popViewController()
}

final class ProfileView: UIView, BaseViewProtocol {
    
    weak var delegate: ProfileViewDelegate?
    let maxNameLength = 8
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "이름을 입력하세요"
        $0.textColor = .label
        $0.font = .bodySB
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "언제든지 변경할 수 있어요"
        $0.textColor = .newsHabitGray
        $0.font = .title3
    }
    
    let textField = UITextField().then {
        $0.text = UserDefaultsManager.username
        $0.font = .body
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .background
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
    }
    
    private let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.body]))
        $0.tintColor = .white
        $0.backgroundColor = .black
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
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        backgroundColor = .background
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
        
        textField.placeholder = "최대 \(maxNameLength)글자"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.becomeFirstResponder()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let delegate = delegate,
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        UIView.animate(withDuration: 0.35) {
            self.saveButton.transform = CGAffineTransform(
                translationX: 0,
                y: delegate.getTabBarHeight() - keyboardSize.height // 탭바 크기
            )
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.35) {
            self.saveButton.transform = .identity
        }
    }
    
    @objc private func handleSaveButtonTap() {
        guard let username = textField.text, !username.isEmpty, username.count <= maxNameLength
        else { return }
        UserDefaultsManager.username = username
        scheduleNotificationWithNewUsernameIfNeeded()
        endEditing(true)
        delegate?.popViewController()
    }
    
    private func scheduleNotificationWithNewUsernameIfNeeded() {
        UserNotificationManager.shared.checkNotificationAuthorization { isAuthorized in
            UserDefaultsManager.isNotificationOn = isAuthorized
            if isAuthorized {
                if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                    UserNotificationManager.shared.scheduleNotification(for: notificationTime)
                }
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            let isValid = !text.isEmpty && text.count <= maxNameLength
            saveButton.isEnabled = isValid
            saveButton.backgroundColor = isValid ? .black : .newsHabitLightGray
        }
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(textField)
        addSubview(saveButton)
    }
    
    func setupLayout() {
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
    
    func setSaveButtonHidden() {
        saveButton.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
}
