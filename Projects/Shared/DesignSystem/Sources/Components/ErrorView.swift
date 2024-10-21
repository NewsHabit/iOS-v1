//
//  ErrorView.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import SnapKit

public final class ErrorView: UIView {
    // MARK: - Components
    
    private let errorImageView = {
        let imageView = UIImageView()
        imageView.image = Images.error
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let errorLabel = {
        let label = UILabel()
        label.setTextWithLineHeight("아이쿠! 뭔가 문제가 있어요\n눌러서 다시 시도해주세요", lineHeight: 20)
        label.font = Fonts.body2
        label.textColor = Colors.gray04
        label.numberOfLines = 2
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
        addSubview(errorImageView)
        errorImageView.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(48)
            make.top.centerX.equalToSuperview()
        }
        
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImageView.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
