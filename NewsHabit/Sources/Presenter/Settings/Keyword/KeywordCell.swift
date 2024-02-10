//
//  KeywordCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/9/24.
//

import UIKit

import SnapKit
import Then

class KeywordCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "KeywordCell"
    
    // MARK: - UI Components
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .white
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        clipsToBounds = true
        layer.cornerRadius = 15
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
