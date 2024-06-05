//
//  TodayNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import UIKit

protocol TodayNewsViewDelegate: AnyObject {
    func pushViewController(_ newsLink: String?)
    func updateNumOfDaysAllRead()
}

final class TodayNewsView: UIView, BaseViewProtocol {
    
    weak var delegate: TodayNewsViewDelegate?
    private var viewModel: TodayNewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let messageView = UIView().then {
        $0.backgroundColor = .tertiarySystemGroupedBackground
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.isHidden = true
    }
    
    private let messageLabel = UILabel().then {
        $0.text = "💬 습관 하루 적립 !  내일도 추천해드릴게요"
        $0.font = .caption
        $0.textColor = .label
    }
    
    private let tableView = UITableView().then {
        $0.register(TodayNewsCell.self, forCellReuseIdentifier: TodayNewsCell.reuseIdentifier)
        $0.backgroundColor = .background
    }
    
    private let errorView = ErrorView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
        errorView.isUserInteractionEnabled = true
        errorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshNews)))
    }
    
    @objc private func refreshNews() {
        self.viewModel?.input.send(.getTodayNews)
    }
    
    func setupHierarchy() {
        addSubview(messageView)
        messageView.addSubview(messageLabel)
        addSubview(tableView)
        addSubview(errorView)
    }
    
    func setupLayout() {
        messageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(44)
        }
        
        messageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    func bindViewModel(_ viewModel: TodayNewsViewModel) {
        self.viewModel = viewModel
        
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .updateTodayNews:
                    errorView.isHidden = true
                    tableView.isHidden = false
                    showAllReadMessageIfNeeded()
                    tableView.reloadData()
                case .fetchFailed:
                    errorView.isHidden = false
                    tableView.isHidden = true
                    hideAllReadMessage()
                case .updateDaysAllRead:
                    delegate?.updateNumOfDaysAllRead()
                    showAllReadMessageIfNeeded()
                case .dayChanged:
                    hideAllReadMessage()
                case let .navigateTo(newsLink):
                    delegate?.pushViewController(newsLink)
                }
            }.store(in: &cancellables)
    }
    
    private func showAllReadMessageIfNeeded() {
        if UserDefaultsManager.monthlyAllRead.contains(Date().toDayString()) {
            messageView.isHidden = false
            
            tableView.snp.remakeConstraints {
                $0.top.equalTo(messageView.snp.bottom).offset(10)
                $0.leading.bottom.trailing.equalToSuperview()
            }
        }
    }
    
    private func hideAllReadMessage() {
        messageView.isHidden = true
        
        tableView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        // 테이블 뷰의 섹션 0에 적어도 하나 이상의 행이 있는지 확인
        if tableView.numberOfRows(inSection: indexPath.section) > 0 {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
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
              let cellViewModel = viewModel?.cellViewModels[indexPath.row] else {
            return UITableViewCell()
        }
        cell.bindViewModel(cellViewModel)
        return cell
    }
    
}
