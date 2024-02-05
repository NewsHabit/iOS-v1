//
//  SettingsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import Combine
import UIKit

import SnapKit
import Then

class SettingsView: BaseView {
    
    // MARK: - Properties
    
    var delegate: SettingsDelegate?
    private var viewModel: SettingsViewModel?
    private var dataSource: UITableViewDiffableDataSource<SettingsSectionViewModel.ID, SettingsCellViewModel.ID>!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.rowHeight = 48
        $0.sectionHeaderTopPadding = 0
        $0.register(
            SettingsCell.self,
            forCellReuseIdentifier: SettingsCell.reuseIdentifier
        )
        $0.register(
            SettingsSection.self,
            forHeaderFooterViewReuseIdentifier: SettingsSection.reuseIdentifier
        )
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupLayout() {
        tableView.delegate = self
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let self = self,
                  let viewModel = self.viewModel?.cellViewModel(forIndexPath: indexPath),
                  let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell
            else { fatalError("error: SettingsView setupDataSource") }
            cell.bindViewModel(viewModel)
            return cell
        }
    }
    
}

// MARK: - Binding View Model

extension SettingsView {
    
    func bindViewModel(_ viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                switch event {
                case .updateSettings:
                    var snapshot = NSDiffableDataSourceSnapshot<SettingsSectionViewModel.ID, SettingsCellViewModel.ID>()
                    viewModel.sectionViewModels.forEach { sectionViewModel in
                        snapshot.appendSections([sectionViewModel.id])
                        if let cellViewModels = sectionViewModel.cellViewModels {
                            snapshot.appendItems(cellViewModels.map { $0.id }, toSection: sectionViewModel.id)
                        }
                    }
                    self?.dataSource.apply(snapshot, animatingDifferences: false)
                }
            }.store(in: &cancellables)
    }
    
}

// MARK: - UITableViewDelegate

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel, let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsSection.reuseIdentifier) as? SettingsSection
        else { return nil }
        headerView.bindViewModel(viewModel.sectionViewModels[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel,
              let settingsType = viewModel.cellViewModel(forIndexPath: indexPath)?.settingsType
        else { return }
        delegate?.pushViewController(settingsType)
    }
    
}
