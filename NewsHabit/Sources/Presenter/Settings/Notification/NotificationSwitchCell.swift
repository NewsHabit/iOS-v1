//
//  NotificationSwitchCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import UIKit

import SnapKit
import Then

final class NotificationSwitchCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "NotificationSwitchCell"
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.text = "오늘의 뉴스 알림"
        $0.font = .largeLabelFont
        $0.textColor = .label
    }
    
    let switchControl = UISwitch().then {
        $0.onTintColor = .newsHabit
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() {
        backgroundColor = .background
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchControl)
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
    
    // MARK: - Configure
    
    func configure(with isOn: Bool) {
        switchControl.isOn = isOn
    }
    
}
