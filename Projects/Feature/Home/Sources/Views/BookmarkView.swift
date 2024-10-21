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
    
    let categoryDropDownButton = CategoryDropDownButton()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
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
        
        addSubview(categoryDropDownButton)
        categoryDropDownButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryDropDownButton.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
