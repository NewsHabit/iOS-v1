//
//  CategoryDropDownButton.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared
import SnapKit

public final class CategoryDropDownButton: UIButton {
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        return stackView
    }()
    
    private let categoryLabel = {
        let label = UILabel()
        label.text = "모든 카테고리"
        label.font = Fonts.caption1
        label.textColor = Colors.gray09
        return label
    }()
    
    private let chevronDownImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = Colors.gray09
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        // Trait 변경 감지를 위한 등록
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
            self.layer.borderColor = Colors.gray01.cgColor
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = Colors.gray01.cgColor
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.leading.trailing.equalToSuperview().inset(9)
            make.height.equalTo(16)
        }
        
        [categoryLabel, chevronDownImageView].forEach { stackView.addArrangedSubview($0) }
    }
}
