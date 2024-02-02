//
//  BaseView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

import SnapKit
import Then

protocol BaseViewProtocol {
    func setupLayout()
}

class BaseView: UIView, BaseViewProtocol {
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupLayout() {
        fatalError("setupLayout() must be overridden")
    }
    
}
