//
//  NotificationTimeView.swift
//  NewsHabit
//
//  Created by jiyeon on 6/6/24.
//

import UIKit

import SnapKit
import Then

final class NotificationTimeView: UIView, BaseViewProtocol {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "시간"
        $0.font = .title2
        $0.textColor = .label
    }
    
    private let timeLabel = UILabel().then {
        $0.font = .title2
        $0.textColor = .newsHabitGray
    }
    
    // MARK: - Initialzier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        backgroundColor = .background
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(timeLabel)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with time: String) {
        timeLabel.text = time
    }
    
}
