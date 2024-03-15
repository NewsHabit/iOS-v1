//
//  ErrorView.swift
//  NewsHabit
//
//  Created by jiyeon on 3/15/24.
//

import UIKit

import SnapKit
import Then

class ErrorView: UIStackView {
    
    // MARK: - UI Components
    
    let faceLabel = UILabel().then {
        $0.text = "😵‍💫😵‍💫😵‍💫"
        $0.font = .largeFont
    }
    
    let messageLabel = UILabel().then {
        $0.text = "아이쿠! 문제가 발생했어요"
        $0.font = .subTitleFont
        $0.textColor = .newsHabitGray
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        axis = .vertical
        spacing = 10
        alignment = .center
        isHidden = true
    }
    
    private func setupHierarchy() {
        addArrangedSubview(faceLabel)
        addArrangedSubview(messageLabel)
    }
    
}
