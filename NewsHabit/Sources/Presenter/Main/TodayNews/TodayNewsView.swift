//
//  TodayNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import UIKit

class TodayNewsView: UIView {
    
    // MARK: - Properties
    
    var delegate: TodayNewsViewDelegate?
    private var viewModel: TodayNewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
        $0.backgroundColor = .clear
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
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: TodayNewsViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                switch event {
                case .updateTodayNews:
                    self?.tableView.reloadData()
                case .updateDaysAllReadCount:
                    self?.delegate?.updateDaysAllReadCount()
                }
            }.store(in: &cancellables)
    }
    
}

extension TodayNewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.input.send(.tapNewsCell(indexPath.row))
        delegate?.pushViewController(viewModel.newsCellViewModels[indexPath.row].newsLink)
    }
    
}

extension TodayNewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.todayNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier) as? NewsCell,
              let cellViewModel = viewModel?.newsCellViewModels[indexPath.row] else { return UITableViewCell() }
        cell.bindViewModel(cellViewModel)
        return cell
    }
    
}
