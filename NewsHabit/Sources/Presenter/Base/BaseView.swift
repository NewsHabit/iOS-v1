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
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    /// 뷰의 레이아웃 설정을 위해 반드시 서브클래스에서 재정의해야 하는 함수
    func setupLayout() {
        fatalError("setupLayout() must be overridden")
    }
    
}
