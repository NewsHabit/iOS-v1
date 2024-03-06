//
//  HotNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import Combine
import UIKit

class HotNewsView: UIView {
    
    var delegate: HotNewsViewDelegate?
    private var viewModel: HotNewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(HotNewsCell.self, forCellReuseIdentifier: HotNewsCell.reuseIdentifier)
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
    }
    
    let faceLabel = UILabel().then {
        $0.text = "😵‍💫😵‍💫😵‍💫"
        $0.font = .largeFont
    }
    
    let errorLabel = UILabel().then {
        $0.text = "아이쿠! 문제가 발생했어요"
        $0.font = .subTitleFont
        $0.textColor = .newsHabitGray
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
        tableView.addSubview(stackView)
        stackView.addArrangedSubview(faceLabel)
        stackView.addArrangedSubview(errorLabel)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
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
                    self.stackView.isHidden = true
                    self.tableView.reloadData()
                case .fetchFailed:
                    self.stackView.isHidden = false
                case let .navigateTo(newsLink):
                    self.delegate?.pushViewController(newsLink)
                }
            }.store(in: &cancellables)
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

