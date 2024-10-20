//
//  SettingsHeaderView.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared
import SnapKit

public final class SettingsHeaderView: UICollectionReusableView {
    // MARK: - Components
    
    private let separatorView = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
}
