//
//  MyNewsHabitView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import UIKit

import SnapKit
import Then

class MyNewsHabitView: UIView {
    
    // MARK: - Properties
    
    var delegate: MyNewsHabitViewDelegate?
    var viewModel: MyNewsHabitViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(MyNewsHabitCell.self, forCellReuseIdentifier: MyNewsHabitCell.reuseIdentifier)
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
    
    func bindViewModel(_ viewModel: MyNewsHabitViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                switch event {
                case .updateMyNewsHabitItems:
                    self?.tableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
}

extension MyNewsHabitView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.present(indexPath)
    }
    
}

extension MyNewsHabitView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.myNewsHabitItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: MyNewsHabitCell.reuseIdentifier) as? MyNewsHabitCell else { return UITableViewCell() }
        cell.bindViewModel(viewModel.myNewsHabitItems[indexPath.row])
        return cell
    }
    
}
