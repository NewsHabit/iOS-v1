//
//  MainView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

import SnapKit
import Then

class MainView: BaseView {
    
    // MARK: - UI
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // 위쪽 모서리 둥글게
    }
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    override func setupLayout() {
        addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
