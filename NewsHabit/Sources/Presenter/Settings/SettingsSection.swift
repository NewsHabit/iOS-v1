//
//  SettingsTableViewSection.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import UIKit

import SnapKit
import Then

class SettingsSection: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SettingsTableViewSection"
    
    var viewModel: SettingsSectionViewModel?
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    // MARK: - Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func bindViewModel(_ viewModel: SettingsSectionViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
    }
    
}
