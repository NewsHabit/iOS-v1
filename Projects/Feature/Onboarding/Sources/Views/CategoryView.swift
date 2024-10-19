//
//  CategoryView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/19/24.
//

import UIKit

import Shared
import SnapKit

public final class CategoryView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.setTextWithLineHeight(
            "관심있는 카테고리를\n모두 선택해주세요",
            lineHeight: Constants.LineHeight.heading1
        )
        label.font = Fonts.heading1
        label.textColor = Colors.gray09
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "관련된 기사를 매일 추천해드릴게요"
        label.font = Fonts.body3
        label.textColor = Colors.gray04
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
        }
        
    }
}
