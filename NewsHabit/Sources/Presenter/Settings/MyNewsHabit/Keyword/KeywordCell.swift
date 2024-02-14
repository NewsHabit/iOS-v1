//
//  KeywordCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

import SnapKit
import Then

class KeywordCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "KeywordCell"
    
    // MARK: - UI Components
    
    let label = UILabel().then {
        $0.font = .cellLabelFont
        $0.textColor = .white
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
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        clipsToBounds = true
        layer.cornerRadius = 15
    }
    
    private func setupHierarchy() {
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
