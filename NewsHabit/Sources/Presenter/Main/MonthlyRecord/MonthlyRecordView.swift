//
//  MonthlyRecordView.swift
//  NewsHabit
//
//  Created by jiyeon on 3/13/24.
//

import UIKit

import SnapKit
import Then

class MonthlyRecordView: UIView {
    
    // MARK: - UI Components
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
    }
    
    let emoticon = UILabel().then {
        $0.text = "🗒️"
        $0.font = .largeFont
    }
    
    let label = UILabel().then {
        $0.text = "공사중이에요!\n조금만 기다려주세요 🤍"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .subTitleFont
        $0.textColor = .newsHabitGray
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(emoticon)
        stackView.addArrangedSubview(label)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
