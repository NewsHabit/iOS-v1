//
//  TodayNewsCountCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

import SnapKit
import Then

class TodayNewsCountCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TodayNewsCountCell"
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.font = .labelFont
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectedButton)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        selectedButton.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setSelected(_ isSelected: Bool) {
        selectedButton.configuration?.image = isSelected ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle")
    }
    
}
