//
//  ErrorView.swift
//  NewsHabit
//
//  Created by jiyeon on 3/15/24.
//

import UIKit

import SnapKit
import Then

final class ErrorView: UIStackView, BaseViewProtocol {
    
    // MARK: - UI Components
    
    private let faceLabel = UILabel().then {
        $0.text = "😵‍💫😵‍💫😵‍💫"
        $0.font = .largeTitle
    }
    
    private let messageLabel = UILabel().then {
        $0.text = "아이쿠! 문제가 발생했어요\n눌러서 다시 시도해주세요"
        $0.numberOfLines = 0
        $0.font = .title3
        $0.textColor = .newsHabitGray
        $0.textAlignment = .center
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
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        axis = .vertical
        spacing = 10
        alignment = .center
        isHidden = true
    }
    
    func setupHierarchy() {
        addArrangedSubview(faceLabel)
        addArrangedSubview(messageLabel)
    }
    
    
    func setupLayout() {}
    
}
