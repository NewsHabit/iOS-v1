//
//  HotNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import Combine
import UIKit

protocol HotNewsViewDelegate: AnyObject {
    func updateDate()
    func pushViewController(_ newsLink: String?)
}

final class HotNewsView: UIView, BaseViewProtocol {
    
    weak var delegate: HotNewsViewDelegate?
    private var viewModel: HotNewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.register(HotNewsCell.self, forCellReuseIdentifier: HotNewsCell.reuseIdentifier)
    }
    
    private let refreshControl = UIRefreshControl()
    
    private let errorView = ErrorView()
    
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
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        errorView.isUserInteractionEnabled = true
        errorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshNews)))
    }
    
    @objc private func refreshNews() {
        self.viewModel?.input.send(.getHotNews)
    }
    
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(errorView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: HotNewsViewModel) {
        self.viewModel = viewModel
        
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .updateHotNews:
                    errorView.isHidden = true
                    tableView.isHidden = false
                    tableView.reloadData()
                    refreshControl.endRefreshing()
                    delegate?.updateDate()
                case .fetchFailed:
                    errorView.isHidden = false
                    tableView.isHidden = true
                    refreshControl.endRefreshing()
                case let .navigateTo(newsLink):
                    delegate?.pushViewController(newsLink)
                }
            }.store(in: &cancellables)
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        // 테이블 뷰의 섹션 0에 적어도 하나 이상의 행이 있는지 확인
        if tableView.numberOfRows(inSection: indexPath.section) > 0 {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}

extension HotNewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input.send(.tapNewsCell(indexPath.row))
    }
    
}

extension HotNewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotNewsCell.reuseIdentifier) as? HotNewsCell,
              let cellViewModel = viewModel?.cellViewModels[indexPath.row] else { return UITableViewCell() }
        cell.bindViewModel(cellViewModel)
        return cell
    }
    
}

