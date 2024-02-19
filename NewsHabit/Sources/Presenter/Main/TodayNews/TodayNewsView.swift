//
//  TodayNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import UIKit

class TodayNewsView: UIView {
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
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
    
}

extension TodayNewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsCell else { return }
        cell.viewModel?.isRead = true
    }
    
}

extension TodayNewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.todayNewsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier) as? NewsCell else { return UITableViewCell() }
        cell.bindViewModel(NewsCellViewModel(newsItem: NewsItem(
            title: "제목이 들어올 자리입니다",
            description: "요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 요약이 들어갈 자리입니다 ",
            category: "사회")))
        return cell
    }
    
}
