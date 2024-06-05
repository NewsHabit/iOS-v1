//
//  NotificationTimeCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import UIKit

final class NotificationTimeCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "NotificationTimeCell"
    
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
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        backgroundColor = .background
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
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
