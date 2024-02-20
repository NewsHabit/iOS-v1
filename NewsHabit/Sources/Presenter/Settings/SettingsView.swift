//
//  SettingsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

import SnapKit
import Then

class SettingsView: UIView {
    
    // MARK: - Properties
    
    var delegate: SettingsViewDelegate?
    let viewModel = SettingsViewModel()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        $0.separatorStyle = .none
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupHierarchy() {
        addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backgroundColor = .clear
        delegate?.pushViewController(indexPath)
    }
    
}

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier) as? SettingsCell else { return UITableViewCell() }
        cell.bindViewModel(viewModel.settingsItems[indexPath.row])
        return cell
    }
    
}
