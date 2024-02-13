//
//  MyNewsHabitCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

struct MyNewsHabitItem {
    let title: String
    let description: String
}

class MyNewsHabitCell: UITableViewCell {
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.textColor = .label
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
    }
    
    let chevronImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .newsHabitLightGray
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(chevronImage)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.equalTo(chevronImage.snp.leading).offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        chevronImage.snp.makeConstraints {
            $0.width.height.equalTo(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
}
