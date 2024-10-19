//
//  DailyNewsView.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared
import SnapKit

public final class DailyNewsView: UIView {
    // MARK: - Components
    
    let errorView = ErrorView()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    let messageView = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let heartImageView = {
        let imageView = UIImageView()
        imageView.image = Images.heart
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.text = "습관 하루 적립! 내일도 추천해드릴게요"
        label.font = Fonts.caption1
        label.textColor = Colors.gray09
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: NewsCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
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
//        addSubview(errorView)
//        errorView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
        
        [heartImageView, messageLabel].forEach { messageView.addSubview($0) }
        [messageView, collectionView].forEach { stackView.addArrangedSubview($0) }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        messageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(heartImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
}
