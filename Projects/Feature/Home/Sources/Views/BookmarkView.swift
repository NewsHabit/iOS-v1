//
//  BookmarkView.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

public final class BookmarkView: UIView {
    // MARK: - Components
    
    let emptyView = EmptyView()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    let searchBarView = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        view.layer.cornerRadius = 22
        return view
    }()
    
    private let searchImageView = {
        let imageView = UIImageView()
        imageView.image = Images.search
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textField = {
        let textField = UITextField()
        textField.placeholder = "기사 제목 검색"
        textField.font = Fonts.caption1
        textField.textColor = Colors.gray09
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .search
        return textField
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: NewsCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
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
//        addSubview(emptyView)
//        emptyView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
        
        [searchImageView, textField].forEach { searchBarView.addSubview($0) }
        [searchBarView, collectionView].forEach { stackView.addArrangedSubview($0) }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        searchBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(14)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
}
