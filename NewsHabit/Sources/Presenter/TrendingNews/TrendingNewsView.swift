//
//  TrendingNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

class TrendingNewsView: UIView {
    
    var dummyDatas = [
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy),
        NewsCellViewModel(newsItem: NewsItem.dummy)
    ]
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
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

extension TrendingNewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dummyDatas[indexPath.row].isRead = true
    }
    
}

extension TrendingNewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier) as? NewsCell else { return UITableViewCell() }
        cell.bindViewModel(dummyDatas[indexPath.row])
        return cell
    }
    
}
