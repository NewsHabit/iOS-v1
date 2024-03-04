//
//  CategoryCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

import SnapKit
import Then

class CategoryCell: UICollectionViewCell {
    
<<<<<<< HEAD:NewsHabit/Sources/Presenter/Settings/MyNewsHabit/Category/CategoryCell.swift
    // MARK: - Properties
    
    static let reuseIdentifier = "CategoryCell"
=======
    static let reuseIdentifier = "KeywordCell"
>>>>>>> 94cc61ccd02e21ab174bd548d59972abc9802ace:NewsHabit/Sources/Presenter/Settings/MyNewsHabit/Keyword/KeywordCell.swift
    
    // MARK: - UI Components
    
    let label = UILabel().then {
        $0.font = .cellLabelFont
        $0.textColor = .systemBackground
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
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 13
    }
    
    private func setupHierarchy() {
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setSelected(_ isSelected: Bool) {
        backgroundColor = isSelected ? .label : .newsHabitLightGray
    }
    
}
