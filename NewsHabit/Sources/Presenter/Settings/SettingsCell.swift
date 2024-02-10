//
//  SettingsTableViewCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import UIKit

import SnapKit
import Then

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SettingsTableViewCell"
    var viewModel: SettingsCellViewModel?
    
    // MARK: - UI Components
    
    let titleLabel = UILabel()
    
    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Bind View Model
    
    func bindViewModel(_ viewModel: SettingsCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        descriptionLabel.textColor = viewModel.descriptionColor
    }
    
}
