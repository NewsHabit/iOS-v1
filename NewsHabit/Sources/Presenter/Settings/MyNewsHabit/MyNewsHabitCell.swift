//
//  MyNewsHabitCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

class MyNewsHabitCell: UITableViewCell {
    
    static let reuseIdentifier = "MyNewsHabitCell"
    private var viewModel: MyNewsHabitItem?
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .largeLabelFont
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .labelFont
    }
    
    let chevronImage = UIImageView().then {
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
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
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
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: MyNewsHabitItem) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.type.rawValue
        descriptionLabel.text = viewModel.description
    }
    
}
