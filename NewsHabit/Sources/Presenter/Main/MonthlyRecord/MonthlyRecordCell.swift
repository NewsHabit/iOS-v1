//
//  MonthlyRecordCell.swift
//  NewsHabit
//
//  Created by jiyeon on 3/20/24.
//

import UIKit

import SnapKit
import Then

class MonthlyRecordCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MonthlyRecordCell"
    
    // MARK: - UI Components
    
    let label = UILabel().then {
        $0.font = .smallFont
        $0.textColor = .newsHabitLightGray
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
    
    override func prepareForReuse() {
        label.text = ""
        label.textColor = .newsHabitLightGray
        backgroundColor = .background
        layer.borderWidth = 0
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setEmpty() {
        backgroundColor = .background
    }
    
    func setRead(_ isRead: Bool, _ isToday: Bool, _ dayString: String) {
        label.text = dayString
        label.textColor = .newsHabitGray
        if isRead {
            backgroundColor = .newsHabit.withAlphaComponent(0.7)
        }
        if isToday {
            layer.borderWidth = 2
            layer.borderColor = UIColor.newsHabit.cgColor
        }
    }
    
}
