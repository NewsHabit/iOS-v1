//
//  SettingsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import Combine
import UIKit

import SnapKit
import Then

protocol SettingsViewDelegate: AnyObject {
    func pushViewController(settingsType: SettingsType)
}

final class SettingsView: UIView, BaseViewProtocol {
    
    weak var delegate: SettingsViewDelegate?
    private var viewModel: SettingsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let tableView = UITableView().then {
        $0.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        $0.backgroundColor = .background
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
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    func bindViewModel(_ viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .initSettingItems:
                    self.tableView.reloadData()
                case let .navigateTo(settingsType):
                    self.delegate?.pushViewController(settingsType: settingsType)
                }
            }.store(in: &cancellables)
    }
    
}

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input.send(.tapSettingsCell(indexPath.row))
    }
    
}

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.settingsItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier) as? SettingsCell,
              let settingsItem = viewModel?.settingsItems[indexPath.row]
        else { return UITableViewCell() }
        cell.bindViewModel(settingsItem)
        return cell
    }
    
}
