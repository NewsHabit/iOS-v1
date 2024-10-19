//
//  MonthlyCell.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared
import SnapKit

public final class MonthlyCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let dayLabel = {
        let label = UILabel()
        label.text = "00"
        label.font = Fonts.caption1
        label.textColor = Colors.background
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        layer.cornerRadius = 5
    }
    
    private func setupLayout() {
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    public func configure(with cellType: MonthlyCellType) {
        switch cellType {
        case .unread:
            backgroundColor = Colors.gray01
        case .read:
            backgroundColor = Colors.primary
        case .empty:
            backgroundColor = .clear
        }
    }
}
