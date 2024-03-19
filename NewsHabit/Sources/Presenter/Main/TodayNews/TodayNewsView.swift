//
//  TodayNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import UIKit

class TodayNewsView: UIView {
    
    var delegate: TodayNewsViewDelegate?
    private var viewModel: TodayNewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.register(TodayNewsCell.self, forCellReuseIdentifier: TodayNewsCell.reuseIdentifier)
        $0.backgroundColor = .clear
    }
    
    let refreshControl = UIRefreshControl()
    
    let errorView = ErrorView()
    
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
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    private func setupHierarchy() {
        addSubview(tableView)
        tableView.addSubview(errorView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func handleRefreshControl() {
        self.viewModel?.input.send(.getTodayNews)
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: TodayNewsViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .updateTodayNews:
                    self.errorView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                case .fetchFailed:
                    self.errorView.isHidden = false
                    self.tableView.isHidden = true
                    self.refreshControl.endRefreshing()
                case .updateDaysAllRead:
                    self.delegate?.updateDaysAllReadCount()
                case let .navigateTo(newsLink):
                    self.delegate?.pushViewController(newsLink)
                }
            }.store(in: &cancellables)
    }
    
}

extension TodayNewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input.send(.tapNewsCell(indexPath.row))
    }
    
}

extension TodayNewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayNewsCell.reuseIdentifier) as? TodayNewsCell,
              let cellViewModel = viewModel?.cellViewModels[indexPath.row] else { return UITableViewCell() }
        cell.bindViewModel(cellViewModel)
        return cell
    }
    
}
