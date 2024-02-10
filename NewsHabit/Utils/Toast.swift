//
//  Toast.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

import SnapKit
import Then

final class Toast {
    
    // MARK: - Properties
    
    private var window: UIWindow?
    
    private var backView = UIView().then {
        $0.backgroundColor = .newsHabitDarkGray.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 15
    }
    
    private var messageLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .subTitleFont
        $0.sizeToFit()
    }
    
    // MARK: - Initializer
    
    static let shared = Toast()
    
    private init() {
        setupWindow()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupWindow() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowLevel = .alert // 디폴트는 normal
        window?.isUserInteractionEnabled = false
    }
    
    private func setupHierarchy() {
        window?.addSubview(backView)
        backView.addSubview(messageLabel)
    }
    
    private func setupLayout() {
        backView.snp.makeConstraints {
            $0.width.equalTo(messageLabel.snp.width).multipliedBy(1.5)
            $0.height.equalTo(messageLabel.snp.height).multipliedBy(2)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(150)
        }
        
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Make Toast !!! 🍞
    
    func makeToast(_ message: String) {
        messageLabel.text = message
        window?.isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.window?.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseIn, animations: {
                self.window?.alpha = 0.0
            }) { _ in
                self.window?.isHidden = true
            }
        }
    }
    
}
