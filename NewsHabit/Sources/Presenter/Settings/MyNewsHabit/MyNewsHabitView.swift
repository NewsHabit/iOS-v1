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

final class MyNewsHabitView: UIView, BaseViewProtocol {
    
    weak var delegate: MyNewsHabitViewDelegate?
    private var viewModel: MyNewsHabitViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
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
    
    func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    func bindViewModel(_ viewModel: MyNewsHabitViewModel) {
        self.viewModel = viewModel
        
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .navigateTo(myNewsHabitType):
                    delegate?.pushViewController(myNewsHabitType: myNewsHabitType)
                case .updateMyNewsHabitItems:
                    tableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
}

extension MyNewsHabitView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input.send(.tapMyNewsHabitCell(indexPath.row))
    }
    
}

extension MyNewsHabitView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.myNewsHabitItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.myNewsHabitItems[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: MyNewsHabitCell.reuseIdentifier) as? MyNewsHabitCell else { return UITableViewCell() }
        cell.bindViewModel(cellViewModel)
        return cell
    }
    
}
