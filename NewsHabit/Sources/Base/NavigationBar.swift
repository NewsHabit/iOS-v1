//
//  NavigationBar.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit

import SnapKit
import Then

final class NavigationBar: UIView {
    
    // MARK: - UI Components
    
    let title = UILabel().then {
        $0.textColor = .label
        $0.font = .titleFont
    }
    
    let backButton = UIButton().then {
        $0.tintColor = .label
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(
            systemName: "chevron.left",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .medium) // 📌
        )
    }
    
    let shareButton = UIButton().then {
        $0.tintColor = .label
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .medium) // 📌
        )
    }
    
    let largeTitleView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5.0 // 📌
    }
    
    let largeTitle = UILabel().then {
        $0.textColor = .label
        $0.font = .largeTitleFont
    }
    
    let subTitle = UILabel().then {
        $0.textColor = .label
        $0.font = .subTitleFont
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        addSubview(title)
        addSubview(backButton)
        addSubview(shareButton)
        addSubview(largeTitleView)
        largeTitleView.addArrangedSubview(largeTitle)
        largeTitleView.addArrangedSubview(subTitle)
    }
    
    private func setupLayout() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(23)
        }
        
        shareButton.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(23)
        }
        
        largeTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
}
