//
//  MainView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        backgroundColor = .systemPink
    }
    
}
