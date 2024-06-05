//
//  MyNewsHabitCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

final class MyNewsHabitCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "MyNewsHabitCell"
    private var item: MyNewsHabitItem?
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .title2
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .body
    }
    
    private let chevronImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .newsHabitGray
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
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(chevronImage)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.equalTo(chevronImage.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        chevronImage.snp.makeConstraints {
            $0.width.equalTo(10)
            $0.height.equalTo(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with item: MyNewsHabitItem) {
        self.item = item
        
        titleLabel.text = item.type.rawValue
        descriptionLabel.text = item.description
    }
    
}
