//
//  SettingsCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

struct SettingsItem {
    let image: UIImage?
    let title: String
}

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SettingsCell"
    private var viewModel: SettingsItem?
    
    // MARK: - UI Components
    
    let image = UIImageView().then {
        $0.tintColor = .label
    }
    
    let label = UILabel().then {
        $0.font = .largeLabelFont
        $0.textColor = .label
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
        selectionStyle = .none
    }
    
    private func setupHierarchy() {
        contentView.addSubview(image)
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        image.snp.makeConstraints {
            $0.width.height.equalTo(19)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing).offset(15)
        }
    }
    
    // MARK: - Binding ViewModel
    
    func bindViewModel(_ viewModel: SettingsItem) {
        self.viewModel = viewModel
        image.image = viewModel.image
        label.text = viewModel.title
    }
    
}
