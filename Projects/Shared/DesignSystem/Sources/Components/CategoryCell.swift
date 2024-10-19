//
//  CategoryCell.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import SharedUtil
import SnapKit

public final class CategoryCell: UICollectionViewCell, Reusable {
    public override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Components
    
    private let nameLabel = {
        let label = UILabel()
        label.font = Fonts.title3
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
        // Trait 변경 감지를 위한 등록
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
            self.updateAppearance()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }
    
    private func setupLayout() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    public func configure(with category: SharedUtil.Category) {
        nameLabel.text = category.name
        updateAppearance()
    }
    
    // TODO: 뷰모델 연결할 때 isSelected 로직 빼야함 (여러개 선택 가능해서) 뷰모델에 isSelected 변수 넣어둘 것
    private func updateAppearance() {
        nameLabel.textColor = isSelected ? Colors.primary : Colors.disabled
        backgroundColor = isSelected ? Colors.secondary : Colors.background
        layer.borderColor = (isSelected ? Colors.background : Colors.gray01).cgColor
    }
}
