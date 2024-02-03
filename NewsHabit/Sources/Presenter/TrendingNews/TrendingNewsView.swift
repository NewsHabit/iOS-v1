//
//  TrendingNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import UIKit

import SnapKit
import Then

class TrendingNewsView: BaseView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupLayout() {
        backgroundColor = .blue.withAlphaComponent(0.1)
    }
}

// MARK: - ViewModel Binding

extension TrendingNewsView {

    
}
