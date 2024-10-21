//
//  MonthlyRecordView.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

public final class MonthlyRecordView: UIView {
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = Date().formatAsMonthYear()
        label.font = Fonts.title2
        label.textColor = Colors.gray09
        label.textAlignment = .center
        return label
    }()
    
    lazy var beforeButton = createButton(with: UIImage(systemName: "chevron.left"))
    
    lazy var afterButton = createButton(with: UIImage(systemName: "chevron.right"))
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 35, height: 30)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: MonthlyCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let heartImageView = {
        let imageView = UIImageView()
        imageView.image = Images.heart
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let countLabel = {
        let label = UILabel()
        label.text = "1"
        label.font = Fonts.title3
        label.textColor = Colors.gray09
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
        [beforeButton, dateLabel, afterButton].forEach { stackView.addArrangedSubview($0) }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(28)
            make.width.equalTo(293)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.bottom).offset(258)
            make.trailing.equalTo(collectionView)
        }
        
        addSubview(heartImageView)
        heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(countLabel)
            make.trailing.equalTo(countLabel.snp.leading).offset(-3)
        }
    }
}

private extension MonthlyRecordView {
    func createButton(with image: UIImage?) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = image
        config.preferredSymbolConfigurationForImage = .init(pointSize: 12)
        let button = UIButton()
        button.backgroundColor = .clear
        button.configuration = config
        button.tintColor = Colors.gray09
        return button
    }
}
