//
//  NicknameView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import Combine
import UIKit

import SnapKit
import Then

class NicknameView: BaseView {
    
    // MARK: - Properties
    
    @Published var isButtonEnabled: Bool = true
    var delegate: NicknameViewDelegate?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    
    let guideLabel = UILabel().then {
        $0.text = "별명을 정해보세요"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .label
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "언제든지 변경할 수 있어요"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .gray
    }
    
    let borderView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    let textField = UITextField().then {
        $0.text = Settings.nickname
        $0.font = .systemFont(ofSize: 16)
        $0.placeholder = "2~6글자 입력"
    }
    
    let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.title = "저장"
        $0.layer.cornerRadius = 8
        $0.tintColor = .white
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupKeyboardNotifications()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup Methods
    
    override func setupLayout() {
        textField.delegate = self
        
        addSubview(guideLabel)
        addSubview(descriptionLabel)
        addSubview(borderView)
        borderView.addSubview(textField)
        addSubview(saveButton)
        
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(23)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(48)
        }
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupBinding() {
        $isButtonEnabled
            .receive(on: RunLoop.main)
            .sink { [weak self] isButtonEnabled in
                self?.saveButton.isEnabled = isButtonEnabled
                if isButtonEnabled {
                    self?.saveButton.backgroundColor = UIColor(red: 166/255, green: 207/255, blue: 178/255, alpha: 1) // 📌
                } else {
                    self?.saveButton.backgroundColor = .systemGray3
                }
            }
            .store(in: &cancellables)
        
        saveButton.addTarget(delegate, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleSaveButtonTap() {
        guard let nickname = textField.text else { return }
        Settings.nickname = nickname
        endEditing(true)
        delegate?.popViewController()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
}

extension NicknameView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        borderView.layer.borderColor = UIColor(red: 166/255, green: 207/255, blue: 178/255, alpha: 1).cgColor // 📌
        borderView.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        borderView.layer.borderColor = UIColor.systemGray3.cgColor
        borderView.layer.borderWidth = 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString?
        else { return true }
        
        let text = currentText.replacingCharacters(in: range, with: string)
        if text.count >= 2 && text.count <= 6 {
            isButtonEnabled = true
            borderView.layer.borderColor = UIColor(red: 166/255, green: 207/255, blue: 178/255, alpha: 1).cgColor
        } else {
            isButtonEnabled = false
            borderView.layer.borderColor = UIColor(red: 239/255, green: 116/255, blue: 116/255, alpha: 1).cgColor
        }
        return true
    }
    
}

extension NicknameView {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let delegate,
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        UIView.animate(withDuration: 0.3) {
            self.saveButton.transform = CGAffineTransform(
                translationX: 0, 
                y: delegate.getTabBarHeight() - keyboardSize.height // 탭바 크기
            )
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.saveButton.transform = .identity
        }
    }
    
}
