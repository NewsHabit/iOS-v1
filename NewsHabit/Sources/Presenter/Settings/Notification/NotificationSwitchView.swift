//
//  NotificationSwitchView.swift
//  NewsHabit
//
//  Created by jiyeon on 6/6/24.
//

import UIKit

import SnapKit
import Then

final class NotificationSwitchView: UIView, BaseViewProtocol {
    
    weak var delegate: NotificationView?
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘의 뉴스 알림"
        $0.font = .title2
        $0.textColor = .label
    }
    
    private let switchControl = UISwitch().then {
        $0.onTintColor = .newsHabit
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
        addSubview(switchControl)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        switchControl.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setSwifthControlAction(_ selector: Selector) {
        switchControl.addTarget(delegate, action: selector, for: .valueChanged)
    }
    
    func configure(with isOn: Bool) {
        switchControl.isOn = isOn
    }
    
}
