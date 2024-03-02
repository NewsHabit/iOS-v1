//
//  ThemeView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/20/24.
//

import Combine
import UIKit

import SnapKit
import Then

class ThemeView: UIView {
    
    private var viewModel: ThemeViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(ThemeCell.self, forCellReuseIdentifier: ThemeCell.reuseIdentifier)
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
            $0.top.equalToSuperview().inset(20)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: ThemeViewModel) {
        self.viewModel = viewModel
        viewModel.$selectedTheme
            .receive(on: RunLoop.main)
            .sink{ [weak self] selectedTheme in
                guard let self = self, let window = self.window else { return }
                UserDefaultsManager.theme = selectedTheme
                window.overrideUserInterfaceStyle = self.toUserInterfaceStyle(themeType: selectedTheme)
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
}

extension ThemeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectedTheme = ThemeType.allCases[indexPath.row]
    }
    
}

extension ThemeView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThemeType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: ThemeCell.reuseIdentifier) as? ThemeCell
        else { return UITableViewCell() }
        cell.bindThemeItem(ThemeType.allCases[indexPath.row])
        cell.setSelected(viewModel.selectedTheme == ThemeType.allCases[indexPath.row])
        return cell
    }
    
}
