//
//  ThemeCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/20/24.
//

import UIKit

import SnapKit
import Then

class ThemeCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ThemeCell"
    
    // MARK: - UI Components
    
    let imageButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 15)
        $0.tintColor = .label
        $0.isUserInteractionEnabled = false
    }
    
    let titleLabel = UILabel().then {
        $0.font = .largeLabelFont
        $0.textColor = .label
    }
    
    let selectedButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 15)
        $0.tintColor = .label
        $0.isUserInteractionEnabled = false
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
        contentView.addSubview(imageButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectedButton)
    }
    
    private func setupLayout() {
        imageButton.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageButton.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        
        selectedButton.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindThemeItem(_ item: ThemeType) {
        imageButton.configuration?.image = UIImage(systemName: item.toImageString())
        titleLabel.text = item.rawValue
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            selectedButton.configuration?.image = UIImage(systemName: "circle.inset.filled")
        } else {
            selectedButton.configuration?.image = UIImage(systemName: "circle")
        }
    }
    
}
