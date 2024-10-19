//
//  EmptyView.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import SnapKit

public final class EmptyView: UIView {
    // MARK: - Components
    
    private let emptyImageView = {
        let imageView = UIImageView()
        imageView.image = Images.empty
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emptyLabel = {
        let label = UILabel()
        label.text = "북마크가 없어요"
        label.font = Fonts.body2
        label.textColor = Colors.gray04
        label.textAlignment = .center
        return label
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
        addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(48)
            make.top.centerX.equalToSuperview()
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
