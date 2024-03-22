//
//  SettingsCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

import SnapKit
import Then

final class SettingsCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "SettingsCell"
    private var viewModel: SettingsItem?
    
    // MARK: - UI Components
    
    let iconImageView = UIImageView().then {
        $0.tintColor = .label
    }
    
    let titleLabel = UILabel().then {
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
    
    func setupProperty() {
        backgroundColor = .background
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
    
    func setupLayout() {
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(19)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(15)
        }
    }
    
    // MARK: - Binding ViewModel
    
    func bindViewModel(_ viewModel: SettingsItem) {
        self.viewModel = viewModel
        iconImageView.image = UIImage(systemName: viewModel.imageString)
        titleLabel.text = viewModel.type.rawValue
    }
    
}
