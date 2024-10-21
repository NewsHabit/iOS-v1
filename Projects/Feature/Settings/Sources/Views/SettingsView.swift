//
//  SettingsView.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared

public final class SettingsView: UIView {
    // MARK: - Components
    
    let headerView = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        return view
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: SettingsCell.self)
        collectionView.register(
            SettingsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader"
        )
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
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
