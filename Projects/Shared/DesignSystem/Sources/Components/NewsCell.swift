//
//  NewsCell.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import SharedUtil
import SnapKit

public final class NewsCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let titleView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        return stackView
    }()
    
    private let readStateView = {
        let view = UIView()
        view.backgroundColor = Colors.point
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.font = Fonts.title2
        label.textColor = Colors.gray09
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        // 컨텐츠 허깅 우선순위를 낮게 설정하여 늘어나도록
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.backgroundColor = .clear
        return view
    }()
    
    private let categoryView = {
        let view = UIView()
        view.backgroundColor = Colors.primary
        view.layer.cornerRadius = 11
        return view
    }()
    
    private let categoryLabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = Fonts.caption2
        label.textColor = Colors.gray00
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션 디스크립션"
        label.font = Fonts.caption1
        label.textColor = Colors.gray04
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        return label
    }()
    
    private let thumbnailImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Colors.gray01
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        return view
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(75)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        categoryView.addSubview(categoryLabel)
        [readStateView, titleLabel, spacerView, categoryView].forEach {
            titleView.addArrangedSubview($0)
        }
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(thumbnailImageView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalTo(thumbnailImageView.snp.leading).offset(-10)
        }
        
        readStateView.snp.makeConstraints { make in
            make.width.height.equalTo(5)
        }
        
        categoryView.snp.makeConstraints { make in
            make.width.equalTo(categoryLabel.snp.width).offset(20)
            make.height.equalTo(22)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleView)
            make.bottom.equalTo(thumbnailImageView.snp.bottom)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Configure
    
    public func configure(with cellType: NewsCellType) {
        switch cellType {
        case .hot:
            readStateView.isHidden = true
            categoryView.isHidden = true
        case .bookmark:
            readStateView.isHidden = true
        default:
            break
        }
    }
}
